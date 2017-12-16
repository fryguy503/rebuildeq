# \CharacterApi

All URIs are relative to *https://app.rebuildeq.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**GetCharacter**](CharacterApi.md#GetCharacter) | **Get** /character/{characterId}/detail | 
[**ListCharacter**](CharacterApi.md#ListCharacter) | **Get** /character | 


# **GetCharacter**
> Character GetCharacter(ctx, characterId)


Get information about a character

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for logging, tracing, authentication, etc.
  **characterId** | **int32**| ID of Character | 

### Return type

[**Character**](Character.md)

### Authorization

[ApiKey](../README.md#ApiKey), [Session](../README.md#Session)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ListCharacter**
> []Character ListCharacter(ctx, )


Get list of owned characters

### Required Parameters
This endpoint does not need any parameter.

### Return type

[**[]Character**](Character.md)

### Authorization

[ApiKey](../README.md#ApiKey), [Session](../README.md#Session)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

