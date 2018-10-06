{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CodeDeploy.DeploymentGroup
    ( LoadBalancerInfo(..)
    , EC2TagSet(..)
    , Deployment(..)
    , EC2TagFilter(..)
    , RevisionLocation(..)
    , DeploymentStyle(..)
    , AlarmConfiguration(..)
    , OnPremisesTagSetListObject(..)
    , GitHubLocation(..)
    , TargetGroupInfo(..)
    , OnPremisesTagSet(..)
    , AutoRollbackConfiguration(..)
    , EC2TagSetListObject(..)
    , Alarm(..)
    , S3Location(..)
    , ELBInfo(..)
    , TriggerConfig(..)
    , TagFilter(..)
    , DeploymentGroup(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data LoadBalancerInfo = LoadBalancerInfo
    { _LoadBalancerInfoElbInfoList :: Maybe [ELBInfo]
    , _LoadBalancerInfoTargetGroupInfoList :: Maybe [TargetGroupInfo]
    } deriving (Show, Eq)

data EC2TagSet = EC2TagSet
    { _EC2TagSetEc2TagSetList :: Maybe [EC2TagSetListObject]
    } deriving (Show, Eq)

data Deployment = Deployment
    { _DeploymentRevision :: RevisionLocation
    , _DeploymentDescription :: Maybe Text
    , _DeploymentIgnoreApplicationStopFailures :: Maybe Bool
    } deriving (Show, Eq)

data EC2TagFilter = EC2TagFilter
    { _EC2TagFilterValue :: Maybe Text
    , _EC2TagFilterKey :: Maybe Text
    , _EC2TagFilterType :: Maybe Text
    } deriving (Show, Eq)

data RevisionLocation = RevisionLocation
    { _RevisionLocationRevisionType :: Maybe Text
    , _RevisionLocationS3Location :: Maybe S3Location
    , _RevisionLocationGitHubLocation :: Maybe GitHubLocation
    } deriving (Show, Eq)

data DeploymentStyle = DeploymentStyle
    { _DeploymentStyleDeploymentOption :: Maybe Text
    , _DeploymentStyleDeploymentType :: Maybe Text
    } deriving (Show, Eq)

data AlarmConfiguration = AlarmConfiguration
    { _AlarmConfigurationIgnorePollAlarmFailure :: Maybe Bool
    , _AlarmConfigurationEnabled :: Maybe Bool
    , _AlarmConfigurationAlarms :: Maybe [Alarm]
    } deriving (Show, Eq)

data OnPremisesTagSetListObject = OnPremisesTagSetListObject
    { _OnPremisesTagSetListObjectOnPremisesTagGroup :: Maybe [TagFilter]
    } deriving (Show, Eq)

data GitHubLocation = GitHubLocation
    { _GitHubLocationCommitId :: Text
    , _GitHubLocationRepository :: Text
    } deriving (Show, Eq)

data TargetGroupInfo = TargetGroupInfo
    { _TargetGroupInfoName :: Maybe Text
    } deriving (Show, Eq)

data OnPremisesTagSet = OnPremisesTagSet
    { _OnPremisesTagSetOnPremisesTagSetList :: Maybe [OnPremisesTagSetListObject]
    } deriving (Show, Eq)

data AutoRollbackConfiguration = AutoRollbackConfiguration
    { _AutoRollbackConfigurationEnabled :: Maybe Bool
    , _AutoRollbackConfigurationEvents :: Maybe [Text]
    } deriving (Show, Eq)

data EC2TagSetListObject = EC2TagSetListObject
    { _EC2TagSetListObjectEc2TagGroup :: Maybe [EC2TagFilter]
    } deriving (Show, Eq)

data Alarm = Alarm
    { _AlarmName :: Maybe Text
    } deriving (Show, Eq)

data S3Location = S3Location
    { _S3LocationBundleType :: Maybe Text
    , _S3LocationETag :: Maybe Text
    , _S3LocationBucket :: Text
    , _S3LocationKey :: Text
    , _S3LocationVersion :: Maybe Text
    } deriving (Show, Eq)

data ELBInfo = ELBInfo
    { _ELBInfoName :: Maybe Text
    } deriving (Show, Eq)

data TriggerConfig = TriggerConfig
    { _TriggerConfigTriggerName :: Maybe Text
    , _TriggerConfigTriggerEvents :: Maybe [Text]
    , _TriggerConfigTriggerTargetArn :: Maybe Text
    } deriving (Show, Eq)

data TagFilter = TagFilter
    { _TagFilterValue :: Maybe Text
    , _TagFilterKey :: Maybe Text
    , _TagFilterType :: Maybe Text
    } deriving (Show, Eq)

data DeploymentGroup = DeploymentGroup
    { _DeploymentGroupEc2TagSet :: Maybe EC2TagSet
    , _DeploymentGroupServiceRoleArn :: Text
    , _DeploymentGroupDeploymentConfigName :: Maybe Text
    , _DeploymentGroupOnPremisesTagSet :: Maybe OnPremisesTagSet
    , _DeploymentGroupEc2TagFilters :: Maybe [EC2TagFilter]
    , _DeploymentGroupLoadBalancerInfo :: Maybe LoadBalancerInfo
    , _DeploymentGroupOnPremisesInstanceTagFilters :: Maybe [TagFilter]
    , _DeploymentGroupApplicationName :: Text
    , _DeploymentGroupTriggerConfigurations :: Maybe [TriggerConfig]
    , _DeploymentGroupAlarmConfiguration :: Maybe AlarmConfiguration
    , _DeploymentGroupDeploymentStyle :: Maybe DeploymentStyle
    , _DeploymentGroupAutoScalingGroups :: Maybe [Text]
    , _DeploymentGroupAutoRollbackConfiguration :: Maybe AutoRollbackConfiguration
    , _DeploymentGroupDeployment :: Maybe Deployment
    , _DeploymentGroupDeploymentGroupName :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''LoadBalancerInfo)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''EC2TagSet)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''Deployment)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''EC2TagFilter)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''RevisionLocation)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''DeploymentStyle)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''AlarmConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 27 } ''OnPremisesTagSetListObject)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''GitHubLocation)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''TargetGroupInfo)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''OnPremisesTagSet)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 26 } ''AutoRollbackConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''EC2TagSetListObject)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Alarm)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''S3Location)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''ELBInfo)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''TriggerConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''TagFilter)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''DeploymentGroup)

resourceJSON :: DeploymentGroup -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CodeDeploy::DeploymentGroup" :: Text), "Properties" .= a ]
