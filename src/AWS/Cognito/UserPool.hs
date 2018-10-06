{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Cognito.UserPool
    ( SmsConfiguration(..)
    , LambdaConfig(..)
    , EmailConfiguration(..)
    , PasswordPolicy(..)
    , SchemaAttribute(..)
    , Policies(..)
    , NumberAttributeConstraints(..)
    , InviteMessageTemplate(..)
    , StringAttributeConstraints(..)
    , DeviceConfiguration(..)
    , AdminCreateUserConfig(..)
    , UserPool(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data SmsConfiguration = SmsConfiguration
    { _SmsConfigurationSnsCallerArn :: Maybe Text
    , _SmsConfigurationExternalId :: Maybe Text
    } deriving (Show, Eq)

data LambdaConfig = LambdaConfig
    { _LambdaConfigPreAuthentication :: Maybe Text
    , _LambdaConfigCreateAuthChallenge :: Maybe Text
    , _LambdaConfigVerifyAuthChallengeResponse :: Maybe Text
    , _LambdaConfigPostAuthentication :: Maybe Text
    , _LambdaConfigCustomMessage :: Maybe Text
    , _LambdaConfigDefineAuthChallenge :: Maybe Text
    , _LambdaConfigPostConfirmation :: Maybe Text
    , _LambdaConfigPreSignUp :: Maybe Text
    } deriving (Show, Eq)

data EmailConfiguration = EmailConfiguration
    { _EmailConfigurationSourceArn :: Maybe Text
    , _EmailConfigurationReplyToEmailAddress :: Maybe Text
    } deriving (Show, Eq)

data PasswordPolicy = PasswordPolicy
    { _PasswordPolicyRequireNumbers :: Maybe Bool
    , _PasswordPolicyRequireUppercase :: Maybe Bool
    , _PasswordPolicyRequireLowercase :: Maybe Bool
    , _PasswordPolicyMinimumLength :: Maybe Int
    , _PasswordPolicyRequireSymbols :: Maybe Bool
    } deriving (Show, Eq)

data SchemaAttribute = SchemaAttribute
    { _SchemaAttributeNumberAttributeConstraints :: Maybe NumberAttributeConstraints
    , _SchemaAttributeRequired :: Maybe Bool
    , _SchemaAttributeAttributeDataType :: Maybe Text
    , _SchemaAttributeStringAttributeConstraints :: Maybe StringAttributeConstraints
    , _SchemaAttributeName :: Maybe Text
    , _SchemaAttributeDeveloperOnlyAttribute :: Maybe Bool
    , _SchemaAttributeMutable :: Maybe Bool
    } deriving (Show, Eq)

data Policies = Policies
    { _PoliciesPasswordPolicy :: Maybe PasswordPolicy
    } deriving (Show, Eq)

data NumberAttributeConstraints = NumberAttributeConstraints
    { _NumberAttributeConstraintsMaxValue :: Maybe Text
    , _NumberAttributeConstraintsMinValue :: Maybe Text
    } deriving (Show, Eq)

data InviteMessageTemplate = InviteMessageTemplate
    { _InviteMessageTemplateEmailSubject :: Maybe Text
    , _InviteMessageTemplateSMSMessage :: Maybe Text
    , _InviteMessageTemplateEmailMessage :: Maybe Text
    } deriving (Show, Eq)

data StringAttributeConstraints = StringAttributeConstraints
    { _StringAttributeConstraintsMaxLength :: Maybe Text
    , _StringAttributeConstraintsMinLength :: Maybe Text
    } deriving (Show, Eq)

data DeviceConfiguration = DeviceConfiguration
    { _DeviceConfigurationChallengeRequiredOnNewDevice :: Maybe Bool
    , _DeviceConfigurationDeviceOnlyRememberedOnUserPrompt :: Maybe Bool
    } deriving (Show, Eq)

data AdminCreateUserConfig = AdminCreateUserConfig
    { _AdminCreateUserConfigAllowAdminCreateUserOnly :: Maybe Bool
    , _AdminCreateUserConfigUnusedAccountValidityDays :: Maybe Double
    , _AdminCreateUserConfigInviteMessageTemplate :: Maybe InviteMessageTemplate
    } deriving (Show, Eq)

data UserPool = UserPool
    { _UserPoolUserPoolTags :: Maybe DA.Value
    , _UserPoolUserPoolName :: Maybe Text
    , _UserPoolEmailVerificationMessage :: Maybe Text
    , _UserPoolSmsAuthenticationMessage :: Maybe Text
    , _UserPoolEmailVerificationSubject :: Maybe Text
    , _UserPoolUsernameAttributes :: Maybe [Text]
    , _UserPoolAliasAttributes :: Maybe [Text]
    , _UserPoolSchema :: Maybe [SchemaAttribute]
    , _UserPoolEmailConfiguration :: Maybe EmailConfiguration
    , _UserPoolSmsVerificationMessage :: Maybe Text
    , _UserPoolMfaConfiguration :: Maybe Text
    , _UserPoolLambdaConfig :: Maybe LambdaConfig
    , _UserPoolSmsConfiguration :: Maybe SmsConfiguration
    , _UserPoolAdminCreateUserConfig :: Maybe AdminCreateUserConfig
    , _UserPoolDeviceConfiguration :: Maybe DeviceConfiguration
    , _UserPoolAutoVerifiedAttributes :: Maybe [Text]
    , _UserPoolPolicies :: Maybe Policies
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''SmsConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''LambdaConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''EmailConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''PasswordPolicy)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''SchemaAttribute)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''Policies)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 27 } ''NumberAttributeConstraints)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''InviteMessageTemplate)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 27 } ''StringAttributeConstraints)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''DeviceConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''AdminCreateUserConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''UserPool)

resourceJSON :: UserPool -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Cognito::UserPool" :: Text), "Properties" .= a ]
