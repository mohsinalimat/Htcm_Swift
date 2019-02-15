//
//  SSAddImage.swift
//  htcm_swift
//
//  Created by soldoros on 2019/1/8.
//  Copyright © 2019 soldoros. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices


//通过UIAlertController 来确定获取方式的时候需要传入键值对
//一下为键值对的key值 目前只提供三种 (相册 图库 摄像头)
let SSPickerWayFormIpc:String = "SSPickerWayFormIpc"
let SSPickerWayGallery:String = "SSPickerWayGallery"
let SSPickerWayCamer:String   = "SSPickerWayCamer"


/// 访问图片的方式
///
/// - SSImagePickerWayFormIpc: 访问相册
/// - SSImagePickerWayGallery: 访问图库
/// - SSImagePickerWayCamer: 访问摄像头
enum SSImagePickerWayStyle {
    case SSImagePickerWayFormIpc
    case SSImagePickerWayGallery
    case SSImagePickerWayCamer
}



/// 获取资源类型
///
/// - SSImagePickerModelImage: 获取图片
/// - SSImagePickerModelVideo: 获取视频
/// - SSImagePickerModelAll: 全部获取
enum SSImagePickerModelType {
    case SSImagePickerModelImage
    case SSImagePickerModelVideo
    case SSImagePickerModelAll
}


///  获取资源后的回调代码块
typealias SSAddImagePicekerBlock = (_ style:SSImagePickerWayStyle,_ type:SSImagePickerModelType,_ datas:Any) -> ()


class SSAddImage: NSObject ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    //访问方式
    var _wayStyle:SSImagePickerWayStyle?
    //获取资源类型
    var _modelType:SSImagePickerModelType?
    //控制器
    var _controller:UIViewController?
    //图片视频控制器核心对象
    var _imagePickerController:UIImagePickerController?
    //回调block
    var _pickerBlock:SSAddImagePicekerBlock?
    
    
    
    /// 直接加载系统的Alert弹窗来判断获取资源的方式 (相册 拍照)
    ///
    /// - Parameters:
    ///   - controller: 控制器对象
    ///   - modelType: 获取的资源类型
    ///   - pickerBlock: 代码块回调
    
    public func getImagePicker(controller:UIViewController,modelType:SSImagePickerModelType,pickerBlock:@escaping SSAddImagePicekerBlock){
        
        let alerts:NSArray = [[SSPickerWayGallery:"相册"],[SSPickerWayCamer:"拍摄"]]
        self .getImagePicker(controller: controller, alerts: alerts, modelType: modelType, pickerBlock: pickerBlock)
    }
    
    
    /// 直接加载系统的Alert弹窗来判断获取资源的方式 (相册 拍照...)
    ///
    /// - Parameters:
    ///   - controller: 控制器对象
    ///   - alerts: 系统Alert对象
    ///   - modelType: 获取资源类型
    ///   - pickerBlock: 代码块回调
    public func getImagePicker(controller:UIViewController,alerts:NSArray,modelType:SSImagePickerModelType,pickerBlock:@escaping SSAddImagePicekerBlock){
        
        _controller = controller
        _modelType = modelType
        _pickerBlock = pickerBlock
        
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        for i:NSInteger in 0...alerts.count-1{
            
            let wayDic:NSDictionary = alerts[i] as! NSDictionary
            let wayKey:NSString = wayDic.allKeys[0] as! NSString
            let wayTitle:NSString = wayDic.value(forKey: wayKey as String) as! NSString
            
            let action = UIAlertAction.init(title: wayTitle as String, style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                if(wayKey as String == SSPickerWayFormIpc){
                    self._wayStyle = SSImagePickerWayStyle.SSImagePickerWayGallery
                    self.addImagePickerFromIpc(modelType: modelType)
                    
                }
                else if(wayKey as String == SSPickerWayGallery){
                    self._wayStyle = SSImagePickerWayStyle.SSImagePickerWayGallery
                    self.addImagePickerFromIpc(modelType: modelType)
                }
                else{
                    self._wayStyle = SSImagePickerWayStyle.SSImagePickerWayCamer
                    self.addImagePickerFromCamer(modelType: modelType)
                }
            }
            
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: nil))
        _controller?.present(alertController, animated: true, completion: nil)
        
    }
    
    
    //通过摄像头获取资源
    func addImagePickerFromCamer(modelType:SSImagePickerModelType){
        if(self.isCameraAvailable() == false){
            print("没有摄像头")
            return
        }
        
        _imagePickerController = UIImagePickerController()
        _imagePickerController?.delegate = self
        _imagePickerController!.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        
        
        //进入摄像头模式
        _imagePickerController!.sourceType = UIImagePickerController.SourceType.camera;
        //视频上传质量
        _imagePickerController!.videoQuality = UIImagePickerController.QualityType.typeHigh;
        
        //可编辑
        _imagePickerController!.allowsEditing = true;
        
        //显示图片
        if(modelType == SSImagePickerModelType.SSImagePickerModelImage){
            _imagePickerController?.mediaTypes = [kUTTypeImage as String]
        }
        //显示视频
        else if(modelType == SSImagePickerModelType.SSImagePickerModelVideo){
            _imagePickerController?.mediaTypes = [kUTTypeMovie as String]
        }
        //全部显示
        else{
            _imagePickerController?.mediaTypes = [kUTTypeImage as String,kUTTypeMovie as String]
        }
        
        _imagePickerController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        
        _controller?.present(_imagePickerController!, animated: true, completion: nil)
        
    }
    
    
    //通过相册获取资源
    func addImagePickerFromIpc(modelType:SSImagePickerModelType){
        if(self.isPhotoLibraryAvailable() == false){
            print("相册不可用")
            return
        }
        
        _imagePickerController = UIImagePickerController()
        _imagePickerController?.delegate = self
        _imagePickerController!.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        _imagePickerController?.allowsEditing = true
        
        //访问相册
        if(_wayStyle == SSImagePickerWayStyle.SSImagePickerWayFormIpc){
            _imagePickerController!.sourceType = UIImagePickerController.SourceType.photoLibrary;
        }
        //访问图库
        else{
            _imagePickerController!.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum;
        }
        
        //显示图片
        if(modelType == SSImagePickerModelType.SSImagePickerModelImage){
            _imagePickerController?.mediaTypes = [kUTTypeImage as String]
        }
            //显示视频
        else if(modelType == SSImagePickerModelType.SSImagePickerModelVideo){
            _imagePickerController?.mediaTypes = [kUTTypeMovie as String]
        }
            //全部显示
        else{
            _imagePickerController?.mediaTypes = [kUTTypeImage as String,kUTTypeMovie as String]
        }
        
        _imagePickerController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        
        _controller?.present(_imagePickerController!, animated: true, completion: nil)
        
    }
    
    //访问相册和摄像头回调
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType:NSString = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        //获取到图片
        if(mediaType as String == kUTTypeImage as String){
            _modelType = SSImagePickerModelType.SSImagePickerModelImage
            self.saveImageAndUpdataHeader(image: info[UIImagePickerController.InfoKey.editedImage] as! UIImage)
        }
        
        //获取到视频
        else if(mediaType as String == kUTTypeMovie as String){
            _modelType = SSImagePickerModelType.SSImagePickerModelVideo
            let url:NSURL = info[UIImagePickerController.InfoKey.mediaURL] as! NSURL
            let urlStr:NSString = url.path! as NSString
            
            //保存视频到相簿
            if(UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr as String)){
                UISaveVideoAtPathToSavedPhotosAlbum(urlStr as String, self, #selector(didFinishSaveVideo(videoPath:)), nil)
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    //图片回调
    func saveImageAndUpdataHeader(image:UIImage){
        if(_pickerBlock != nil){
            _pickerBlock!(_wayStyle!,_modelType!,image)
        }
        else{
            _pickerBlock = nil
        }
    }
    
    
    //视频保存
    @objc func didFinishSaveVideo(videoPath:NSString){
        print("视频保存成功")
        if(_pickerBlock != nil){
            _pickerBlock!(_wayStyle!,_modelType!,videoPath)
        }
        else{
            _pickerBlock = nil
        }
    }
    
    
    //判断是否有摄像头
    func isCameraAvailable()->Bool{
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
    }
    
    
    //判断相册是否可用
    func isPhotoLibraryAvailable()->Bool{
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)
    }
}
