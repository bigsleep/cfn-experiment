{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CloudFront.Distribution
    ( CustomOriginConfig(..)
    , Logging(..)
    , Origin(..)
    , LambdaFunctionAssociation(..)
    , GeoRestriction(..)
    , ForwardedValues(..)
    , Restrictions(..)
    , DistributionConfig(..)
    , CustomErrorResponse(..)
    , S3OriginConfig(..)
    , DefaultCacheBehavior(..)
    , ViewerCertificate(..)
    , Cookies(..)
    , CacheBehavior(..)
    , OriginCustomHeader(..)
    , Distribution(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data CustomOriginConfig = CustomOriginConfig
    { _CustomOriginConfigOriginProtocolPolicy :: Text
    , _CustomOriginConfigOriginKeepaliveTimeout :: Maybe Int
    , _CustomOriginConfigHTTPPort :: Maybe Int
    , _CustomOriginConfigHTTPSPort :: Maybe Int
    , _CustomOriginConfigOriginReadTimeout :: Maybe Int
    , _CustomOriginConfigOriginSSLProtocols :: Maybe [Text]
    } deriving (Show, Eq)

data Logging = Logging
    { _LoggingPrefix :: Maybe Text
    , _LoggingBucket :: Text
    , _LoggingIncludeCookies :: Maybe Bool
    } deriving (Show, Eq)

data Origin = Origin
    { _OriginCustomOriginConfig :: Maybe CustomOriginConfig
    , _OriginOriginCustomHeaders :: Maybe [OriginCustomHeader]
    , _OriginS3OriginConfig :: Maybe S3OriginConfig
    , _OriginOriginPath :: Maybe Text
    , _OriginDomainName :: Text
    , _OriginId :: Text
    } deriving (Show, Eq)

data LambdaFunctionAssociation = LambdaFunctionAssociation
    { _LambdaFunctionAssociationLambdaFunctionARN :: Maybe Text
    , _LambdaFunctionAssociationEventType :: Maybe Text
    } deriving (Show, Eq)

data GeoRestriction = GeoRestriction
    { _GeoRestrictionRestrictionType :: Text
    , _GeoRestrictionLocations :: Maybe [Text]
    } deriving (Show, Eq)

data ForwardedValues = ForwardedValues
    { _ForwardedValuesQueryStringCacheKeys :: Maybe [Text]
    , _ForwardedValuesHeaders :: Maybe [Text]
    , _ForwardedValuesCookies :: Maybe Cookies
    , _ForwardedValuesQueryString :: Bool
    } deriving (Show, Eq)

data Restrictions = Restrictions
    { _RestrictionsGeoRestriction :: GeoRestriction
    } deriving (Show, Eq)

data DistributionConfig = DistributionConfig
    { _DistributionConfigHttpVersion :: Maybe Text
    , _DistributionConfigEnabled :: Bool
    , _DistributionConfigAliases :: Maybe [Text]
    , _DistributionConfigDefaultRootObject :: Maybe Text
    , _DistributionConfigPriceClass :: Maybe Text
    , _DistributionConfigCustomErrorResponses :: Maybe [CustomErrorResponse]
    , _DistributionConfigWebACLId :: Maybe Text
    , _DistributionConfigIPV6Enabled :: Maybe Bool
    , _DistributionConfigViewerCertificate :: Maybe ViewerCertificate
    , _DistributionConfigRestrictions :: Maybe Restrictions
    , _DistributionConfigOrigins :: Maybe [Origin]
    , _DistributionConfigLogging :: Maybe Logging
    , _DistributionConfigCacheBehaviors :: Maybe [CacheBehavior]
    , _DistributionConfigDefaultCacheBehavior :: Maybe DefaultCacheBehavior
    , _DistributionConfigComment :: Maybe Text
    } deriving (Show, Eq)

data CustomErrorResponse = CustomErrorResponse
    { _CustomErrorResponseResponsePagePath :: Maybe Text
    , _CustomErrorResponseResponseCode :: Maybe Int
    , _CustomErrorResponseErrorCachingMinTTL :: Maybe Double
    , _CustomErrorResponseErrorCode :: Int
    } deriving (Show, Eq)

data S3OriginConfig = S3OriginConfig
    { _S3OriginConfigOriginAccessIdentity :: Maybe Text
    } deriving (Show, Eq)

data DefaultCacheBehavior = DefaultCacheBehavior
    { _DefaultCacheBehaviorAllowedMethods :: Maybe [Text]
    , _DefaultCacheBehaviorViewerProtocolPolicy :: Text
    , _DefaultCacheBehaviorLambdaFunctionAssociations :: Maybe [LambdaFunctionAssociation]
    , _DefaultCacheBehaviorMaxTTL :: Maybe Double
    , _DefaultCacheBehaviorTargetOriginId :: Text
    , _DefaultCacheBehaviorMinTTL :: Maybe Double
    , _DefaultCacheBehaviorCompress :: Maybe Bool
    , _DefaultCacheBehaviorSmoothStreaming :: Maybe Bool
    , _DefaultCacheBehaviorCachedMethods :: Maybe [Text]
    , _DefaultCacheBehaviorDefaultTTL :: Maybe Double
    , _DefaultCacheBehaviorForwardedValues :: ForwardedValues
    , _DefaultCacheBehaviorTrustedSigners :: Maybe [Text]
    , _DefaultCacheBehaviorFieldLevelEncryptionId :: Maybe Text
    } deriving (Show, Eq)

data ViewerCertificate = ViewerCertificate
    { _ViewerCertificateSslSupportMethod :: Maybe Text
    , _ViewerCertificateAcmCertificateArn :: Maybe Text
    , _ViewerCertificateMinimumProtocolVersion :: Maybe Text
    , _ViewerCertificateIamCertificateId :: Maybe Text
    , _ViewerCertificateCloudFrontDefaultCertificate :: Maybe Bool
    } deriving (Show, Eq)

data Cookies = Cookies
    { _CookiesWhitelistedNames :: Maybe [Text]
    , _CookiesForward :: Text
    } deriving (Show, Eq)

data CacheBehavior = CacheBehavior
    { _CacheBehaviorAllowedMethods :: Maybe [Text]
    , _CacheBehaviorViewerProtocolPolicy :: Text
    , _CacheBehaviorLambdaFunctionAssociations :: Maybe [LambdaFunctionAssociation]
    , _CacheBehaviorMaxTTL :: Maybe Double
    , _CacheBehaviorTargetOriginId :: Text
    , _CacheBehaviorMinTTL :: Maybe Double
    , _CacheBehaviorCompress :: Maybe Bool
    , _CacheBehaviorSmoothStreaming :: Maybe Bool
    , _CacheBehaviorCachedMethods :: Maybe [Text]
    , _CacheBehaviorDefaultTTL :: Maybe Double
    , _CacheBehaviorForwardedValues :: ForwardedValues
    , _CacheBehaviorTrustedSigners :: Maybe [Text]
    , _CacheBehaviorPathPattern :: Text
    , _CacheBehaviorFieldLevelEncryptionId :: Maybe Text
    } deriving (Show, Eq)

data OriginCustomHeader = OriginCustomHeader
    { _OriginCustomHeaderHeaderValue :: Text
    , _OriginCustomHeaderHeaderName :: Text
    } deriving (Show, Eq)

data Distribution = Distribution
    { _DistributionDistributionConfig :: DistributionConfig
    , _DistributionTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''CustomOriginConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Logging)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Origin)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 26 } ''LambdaFunctionAssociation)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''GeoRestriction)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''ForwardedValues)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''Restrictions)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''DistributionConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''CustomErrorResponse)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''S3OriginConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''DefaultCacheBehavior)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 18 } ''ViewerCertificate)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Cookies)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''CacheBehavior)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''OriginCustomHeader)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''Distribution)

resourceJSON :: Distribution -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CloudFront::Distribution" :: Text), "Properties" .= a ]
