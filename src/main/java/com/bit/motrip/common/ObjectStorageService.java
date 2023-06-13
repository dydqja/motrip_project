package com.bit.motrip.common;

import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.AmazonS3Exception;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.File;

public class ObjectStorageService {
    // constructor

    public ObjectStorageService() {
    }

    //fields

    final String endPoint = "https://kr.object.ncloudstorage.com";
    final String regionName = "kr-standard";

    final String accessKey = "wV4ogI997FpHvMbe6sFL";

    final String secretKey = "GEEoDPwXKssD2hCvf3hijR21z8eKxeR464sGcQoo";


    // S3 client
    final AmazonS3 s3 = AmazonS3ClientBuilder.standard()
            .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endPoint, regionName))
            .withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
            .build();

    String bucketName = "motrip-images";

    String folderName = "images/";

    String objectName = "images/motrip-images";
    String filePath = "c:\\images\\20230612_205755_memo_user2_Pokémon_Pikachu_art.png";


    // create folder


    public void createFolder(String folderName) {


        ObjectMetadata objectMetadata = new ObjectMetadata();
        objectMetadata.setContentLength(0L);
        objectMetadata.setContentType("application/x-directory");
        PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, folderName, new ByteArrayInputStream(new byte[0]), objectMetadata);
        try {
            s3.putObject(putObjectRequest);
            System.out.format("Folder %s has been created.\n", folderName);
        } catch (AmazonS3Exception e) {
            e.printStackTrace();
        } catch (SdkClientException e) {
            e.printStackTrace();
        }
    }

    // upload local file
    public void uploadFile(String objectName, String filePath){

        try {
            s3.putObject(bucketName, objectName, new File(filePath));
            System.out.format("Object %s has been created.\n", objectName);
        } catch (AmazonS3Exception e) {
            e.printStackTrace();
        } catch (SdkClientException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        ObjectStorageService objectStorageService = new ObjectStorageService();
        objectStorageService.createFolder(objectStorageService.folderName);
        objectStorageService.uploadFile(objectStorageService.objectName, objectStorageService.filePath);
    }
}
