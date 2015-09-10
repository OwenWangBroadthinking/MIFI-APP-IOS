//
//  MKZlib.m
//  TSMClientCore
//
//  Created by chendd on 14-5-24.
//  Copyright (c) 2014年 chendd. All rights reserved.
//

#import "DDGzip.h"

@implementation DDGzip
+(NSData *)compress:(NSData *)data{
    if(!data||[data length]==0){
        NSLog(@"%s:Error:Can't compress an empty or null NSData object.",__func__);
        return nil;
    }
    z_stream zlibStreamStruct;
    zlibStreamStruct.zalloc=Z_NULL;
    zlibStreamStruct.zfree=Z_NULL;
    zlibStreamStruct.opaque=Z_NULL;
    zlibStreamStruct.total_out=0;
    zlibStreamStruct.next_in=(Bytef*)[data bytes];
    zlibStreamStruct.avail_in=(int)[data length];
    int initError=deflateInit2(&zlibStreamStruct,
                               Z_DEFAULT_COMPRESSION,
                               Z_DEFLATED,
                               (15+16),
                               8,
                               Z_DEFAULT_STRATEGY);
    if(initError!=Z_OK){
        NSString * errMsg=nil;
        switch (initError) {
            case Z_STREAM_ERROR:
                errMsg=@"Invalid parameter passed in to function." ;
                break;
            case Z_MEM_ERROR:
                errMsg=@"Insufficient memory." ;
                break;
            case Z_VERSION_ERROR:
                errMsg=@"The version of zlib.h and the version of the library linked do not match." ;
                break;
            default:
                errMsg= @"Unknown error code." ;
                break;
        }
        NSLog(@"%s:deflateInit2()Error:[%@] Message:[%s]",__func__,errMsg,zlibStreamStruct.msg);
        return nil;
    }
    NSMutableData * compressedData=[NSMutableData dataWithLength:[data length]*1.01+12];
    int deflateStatus;
    do{
        zlibStreamStruct.next_out=[compressedData mutableBytes]+zlibStreamStruct.total_out;
        zlibStreamStruct. avail_out = (unsigned int)[compressedData length ] - (unsigned int)zlibStreamStruct. total_out ;
        deflateStatus = deflate (&zlibStreamStruct, Z_FINISH );
    }while ( deflateStatus == Z_OK );
    if (deflateStatus != Z_STREAM_END )
    {
        NSString *errorMsg = nil ;
        switch (deflateStatus)
        {
            case Z_ERRNO :
                errorMsg = @"Error occured while reading file." ;
                break ;
            case Z_STREAM_ERROR :
                errorMsg = @"The stream state was inconsistent (e.g., next_in or next_out was NULL)." ;
                break ;
            case Z_DATA_ERROR :
                errorMsg = @"The deflate data was invalid or incomplete." ;
                break ;
            case Z_MEM_ERROR :
                errorMsg = @"Memory could not be allocated for processing." ;
                break ;
            case Z_BUF_ERROR :
                errorMsg = @"Ran out of output buffer for writing compressed bytes." ;
                break ;
            case Z_VERSION_ERROR :
                errorMsg = @"The version of zlib.h and the version of the library linked do not match." ;
                break ;
            default :
                errorMsg = @"Unknown error code." ;
                break ;
        }
        NSLog ( @"%s: zlib error while attempting compression:[%@] Message:[%s]" , __func__, errorMsg, zlibStreamStruct. msg );
        deflateEnd(&zlibStreamStruct);
        return nil;
    }
    deflateEnd(&zlibStreamStruct);
    [compressedData setLength:zlibStreamStruct.total_out];
    return compressedData;
}
+(NSData *)decompress:(NSData *)data{
    z_stream zStream;
    zStream. zalloc = Z_NULL ;
    zStream. zfree = Z_NULL ;
    zStream. opaque = Z_NULL ;
    zStream. avail_in = 0 ;
    zStream. next_in = 0 ;
    int status = inflateInit2 (&zStream, ( 15 + 32 ));
    if (status != Z_OK ) {
        return nil ;
    }
    
    Bytef *bytes = ( Bytef *)[data bytes ];
    NSUInteger length = [data length ];
    NSUInteger halfLength = length/ 2 ;
    NSMutableData *uncompressedData = [ NSMutableData dataWithLength :length+halfLength];
    zStream. next_in = bytes;
    zStream. avail_in = ( unsigned int )length;
    zStream. avail_out = 0 ;
    
    NSInteger bytesProcessedAlready = zStream. total_out ;
    while (zStream. avail_in != 0 ) {
        if (zStream. total_out - bytesProcessedAlready >= [uncompressedData length ]) {
            [uncompressedData increaseLengthBy :halfLength];
        }
        
        zStream. next_out = ( Bytef *)[uncompressedData mutableBytes ] + zStream. total_out -bytesProcessedAlready;
        zStream. avail_out = ( unsigned int )([uncompressedData length ] - (zStream. total_out -bytesProcessedAlready));
        status = inflate (&zStream, Z_NO_FLUSH );
        if (status == Z_STREAM_END ) {
            break ;
        } else if (status != Z_OK ) {
            return nil ;
            
        }
    }
    status = inflateEnd (&zStream);
    if (status != Z_OK ) {
        return nil ;
    }
    [uncompressedData setLength : zStream. total_out -bytesProcessedAlready];  // Set real length
    return uncompressedData;
}
@end
