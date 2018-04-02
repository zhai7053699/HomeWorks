//
//  AddVideo.m
//  MusicToVideo
//
//  Created by 翟永胜 on 2018/4/1.
//  Copyright © 2018年 翟永胜. All rights reserved.
//

#import "AddVideo.h"
#import "CommonHeader.h"
#import<MobileCoreServices/MobileCoreServices.h>


@interface AddVideo ()
{
    // AVFoundation
    AVAsset * videoAsset;
    AVAssetExportSession *exporter;
    
    AVMutableCompositionTrack *AudioTrack;
    
    UIImagePickerController* Videopicker;
    
    NSURL *videoPath;
}

@end

@implementation AddVideo


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void) createUI {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"选取本地视频" forState:UIControlStateNormal];
    [button.titleLabel sizeToFit];
    [button addTarget:self action:@selector(addVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.frame = CGRectMake(SCREEN_WIDTH*0.5-75, 100, 150, 50);
    
    [button setBackgroundColor:[UIColor redColor]];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"添加背景音乐" forState:UIControlStateNormal];
    [button2 sizeToFit];
    [button2 addTarget:self action:@selector(addMusic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    button2.frame = CGRectMake(SCREEN_WIDTH*0.5-75, 200, 150, 50);
    [button2 setBackgroundColor:[UIColor redColor]];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"读取本地音乐" forState:UIControlStateNormal];
    [button3.titleLabel sizeToFit];
    [button3 addTarget:self action:@selector(readMusic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    button3.frame = CGRectMake(SCREEN_WIDTH*0.5-75, 300, 150, 50);
    [button3 setBackgroundColor:[UIColor redColor]];
    
}

- (void) addVideo {
//    NSURL *videoPath1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"selfS" ofType:@"MOV"]];
//    NSURL *videoPath2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"selfH" ofType:@"MOV"]];
//    [self addFirstVideo:videoPath1 andSecondVideo:videoPath2 withMusic:nil];
    [self readLocalVideo];
}

- (void) readMusic {
    // 获取了工程中的mp3文件，从结果看还是输出了工程中的音乐music.mp3。
//    NSArray *mp3Array = [NSBundle pathsForResourcesOfType:@"mp3" inDirectory:[[NSBundle mainBundle] resourcePath]];
//    NSInteger cou = mp3Array.count;
//    for (NSString *filePath in mp3Array) {
//        NSURL *url = [NSURL fileURLWithPath:filePath];
//        NSString *MusicName = [filePath lastPathComponent];
//        AVURLAsset *mp3Asset = [AVURLAsset URLAssetWithURL:url options:nil];
//        NSLog(@"音乐名字：%@ 音乐Asset：%@", MusicName,mp3Asset);
//
//    }
    
    MPMusicPlayerController*musicPlayer=[MPMusicPlayerController systemMusicPlayer];
//    [musicPlayer setRepeatMode:MPMusicShuffleModeSongs]; // 随机播放
    
    [musicPlayer beginGeneratingPlaybackNotifications];//开启通知，否则监控不到MPMusicPlayerController的通知
    // 获取所有播放歌曲
    MPMediaQuery *mediaQueue = [MPMediaQuery songsQuery];
    // 手动选择音乐源
//    MPMediaPickerController * mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeAny];
//    mediaPicker.allowsPickingMultipleItems=NO;//允许多选
//    mediaPicker.prompt=@"请选择要播放的音乐";
//    mediaPicker.delegate=self;//设置选择器代理
    
    [musicPlayer setQueueWithQuery:mediaQueue];//用播放队列设置媒体源
    
    // 读取不到歌曲
//    NSMutableArray *array=[NSMutableArray array];
//    for (MPMediaItem *item in mediaQueue.items) {
//        [array addObject:item];
//        NSLog(@"mpmediaItem is : %@",item);
//    }
    
    [musicPlayer play];
    
    [MPMusicPlayerController applicationMusicPlayer]; // 应用退出后停止播放
//    [musicPlayer setQueueWithItemCollection:mediaItemCollection];//用播放集设置媒体源
    
}

// 没有检索到iTurns 和 酷狗音乐
- (void) QueryAllMusic
{
    MPMediaQuery *everything = [MPMediaQuery songsQuery];
    NSLog(@"Logging items from a generic query...");
    NSArray *itemsFromGenericQuery = [everything items];
    NSLog(@"count = %lu", (unsigned long)itemsFromGenericQuery.count);
    for (MPMediaItem *song in itemsFromGenericQuery)
    {
        NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
        NSString *songArtist = [song valueForProperty:MPMediaItemPropertyArtist];
        NSLog (@"Title:%@, Aritist:%@", songTitle, songArtist);
    }
}

- (void) addMusic {
    // 第一步，从手机相册选取视频文件，生成videoURL
    
    NSLog(@"videoPath == %@",videoPath);
    
    // 第二步，从网络中选择音乐，想添加的背景音乐，生成musicURL
    
    // 第三步，调用addVideo:withMusic函数，实现功能
//    NSURL *videoPath1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"selfS" ofType:@"MOV"]];
//    NSURL *videoPath2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"selfH" ofType:@"MOV"]];
    NSURL *music = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"music" ofType:@"mp3"]];
//    [self addFirstVideo:videoPath1 andSecondVideo:videoPath2 withMusic:music];
    [self addVideoPath:videoPath withMusic:music];
}

// 读取手机相册视频
- (void) readLocalVideo {
    if (Videopicker == nil) {
        Videopicker = [[UIImagePickerController alloc] init];
        Videopicker.delegate = self;
        [Videopicker setEditing:NO];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == YES) {
        Videopicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        Videopicker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
//        [self.navigationController presentModalViewController:Videopicker animated:YES];
        [self showImagePicker];
    } else {
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"不支持视频库" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
        
    }
}

// 获取手机相机视频等权限
- (void) showImagePicker {
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted){
                if(granted){
                    [self presentViewController:Videopicker animated:YES completion:NULL];
                }else{
//                    [self showAlert:@"媒体(相机、相册)访问未授权"];
                    [SVProgressHUD showInfoWithStatus:@"媒体(相机、相册)访问未授权"];
                    return;
                }
            }];
        }
            break;
            
        case AVAuthorizationStatusAuthorized:
            [self presentViewController:Videopicker animated:YES completion:NULL];
            break;
        default:
//            [self showAlert:@"请先在系统设置中对该应用开启相机、相册访问权限"];
            [SVProgressHUD showInfoWithStatus:@"请先在系统设置中对该应用开启相机、相册访问权限"];
            break;
    }
}

// 视频处理完毕回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info; {
    
    
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        if ([info valueForKey:UIImagePickerControllerOriginalImage]) {
            UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage]; //原始图片
            //处理图片信息`info` ...
            
        }else{
            //处理视频信息 `info` ...
            videoPath = [info objectForKey:UIImagePickerControllerMediaURL];
        }
    }else{
        if (picker.cameraCaptureMode == UIImagePickerControllerCameraCaptureModeVideo) {
            //处理视频信息 `info`
            NSLog(@"视频URL是：%@",[info valueForKey:UIImagePickerControllerMediaURL]);
//            strVideoPath = [info valueForKey:UIImagePickerControllerMediaURL];
        }else{
            UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage]; //原始图片
            //处理图片信息`info`   ...
        }
    }
    
    
    NSLog(@"%@",info.description);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//-(void)addFirstVideo:(NSURL*)firstVideoPath andSecondVideo:(NSURL*)secondVideo withMusic:(NSURL*)musicPath{
- (void) addVideoPath:(NSURL*)firstVideoPath withMusic:(NSURL*)musicPath{

    [SVProgressHUD showWithStatus:@"正在合成到系统相册中"];
    
    AVAsset *firstAsset = [AVAsset assetWithURL:firstVideoPath];
//    AVAsset *secondAsset = [AVAsset assetWithURL:secondVideo];
    AVAsset *musciAsset = [AVAsset assetWithURL:musicPath];
    
    // 1 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    // 2 - Video track
    AVMutableCompositionTrack *firstTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    [firstTrack insertTimeRange:CMTimeRangeFromTimeToTime(kCMTimeZero, firstAsset.duration)
                        ofTrack:[[firstAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:kCMTimeZero error:nil];
//    [firstTrack insertTimeRange:CMTimeRangeFromTimeToTime(kCMTimeZero, secondAsset.duration)
//                        ofTrack:[[secondAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:firstAsset.duration error:nil];
    
    if (musciAsset!=nil){
        AudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                 preferredTrackID:kCMPersistentTrackID_Invalid];
//        [AudioTrack insertTimeRange:CMTimeRangeFromTimeToTime(kCMTimeZero, CMTimeAdd(firstAsset.duration, secondAsset.duration))
//                            ofTrack:[[musciAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];
        [AudioTrack insertTimeRange:CMTimeRangeFromTimeToTime(kCMTimeZero, CMTimeAdd(kCMTimeZero, firstAsset.duration))
                            ofTrack:[[musciAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];
    }
    
    
    // 4 - Get path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
                             [NSString stringWithFormat:@"mergeVideo-%d.mov",arc4random() % 1000]];
    NSURL *url = [NSURL fileURLWithPath:myPathDocs];
    // 5 - Create exporter
    exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                presetName:AVAssetExportPresetHighestQuality];
    
    //修改背景音乐的音量start
    AVMutableAudioMix *videoAudioMixTools = [AVMutableAudioMix audioMix];
    if (musciAsset) {
        //调节音量
        //获取音频轨道
        AVMutableAudioMixInputParameters *firstAudioParam = [AVMutableAudioMixInputParameters audioMixInputParametersWithTrack:AudioTrack];
        //设置音轨音量,可以设置渐变,设置为1.0就是全音量
//        [firstAudioParam setVolumeRampFromStartVolume:1.0 toEndVolume:1.0 timeRange:CMTimeRangeMake(kCMTimeZero, CMTimeAdd(firstAsset.duration, secondAsset.duration))];
        [firstAudioParam setVolumeRampFromStartVolume:1.0 toEndVolume:1.0 timeRange:CMTimeRangeMake(kCMTimeZero, CMTimeAdd(kCMTimeZero, firstAsset.duration))];
        [firstAudioParam setTrackID:AudioTrack.trackID];
        videoAudioMixTools.inputParameters = [NSArray arrayWithObject:firstAudioParam];
    }
    //end
    
    exporter.outputURL=url;
    exporter.outputFileType = AVFileTypeQuickTimeMovie;
    exporter.audioMix = videoAudioMixTools;
    exporter.shouldOptimizeForNetworkUse = YES;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self exportDidFinish:exporter];
        });
    }];
}

- (void)exportDidFinish:(AVAssetExportSession*)session {
    if (session.status == AVAssetExportSessionStatusCompleted) {
        NSURL *outputURL = session.outputURL;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            __block PHObjectPlaceholder *placeholder;
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(outputURL.path)) {
                NSError *error;
                [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                    PHAssetChangeRequest* createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:outputURL];
                    placeholder = [createAssetRequest placeholderForCreatedAsset];
                } error:&error];
                if (error) {
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error]];
                }
                else{
                    [SVProgressHUD showSuccessWithStatus:@"视频已经保存到相册"];
                }
            }else {
                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"视频保存相册失败，请设置软件读取相册权限", nil)];
                
            }
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
