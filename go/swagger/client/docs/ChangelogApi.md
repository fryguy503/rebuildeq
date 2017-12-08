# \ChangelogApi

All URIs are relative to *https://app.rebuildeq.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**GetChangelog**](ChangelogApi.md#GetChangelog) | **Get** /changelog/{id} | 
[**GetChangelogs**](ChangelogApi.md#GetChangelogs) | **Get** /changelogs | 


# **GetChangelog**
> Changelog GetChangelog(ctx, id)


Get changelog by id

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for logging, tracing, authentication, etc.
  **id** | **string**| ID of changelog | 

### Return type

[**Changelog**](Changelog.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **GetChangelogs**
> Changelogs GetChangelogs(ctx, )


Get listing of most recent changelog

### Required Parameters
This endpoint does not need any parameter.

### Return type

[**Changelogs**](Changelogs.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

