{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Cognito.IdentityPoolRoleAttachment
    ( RulesConfigurationType(..)
    , RoleMapping(..)
    , MappingRule(..)
    , IdentityPoolRoleAttachment(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data RulesConfigurationType = RulesConfigurationType
    { _RulesConfigurationTypeRules :: [MappingRule]
    } deriving (Show, Eq)

data RoleMapping = RoleMapping
    { _RoleMappingRulesConfiguration :: Maybe RulesConfigurationType
    , _RoleMappingType :: Text
    , _RoleMappingAmbiguousRoleResolution :: Maybe Text
    } deriving (Show, Eq)

data MappingRule = MappingRule
    { _MappingRuleMatchType :: Text
    , _MappingRuleValue :: Text
    , _MappingRuleClaim :: Text
    , _MappingRuleRoleARN :: Text
    } deriving (Show, Eq)

data IdentityPoolRoleAttachment = IdentityPoolRoleAttachment
    { _IdentityPoolRoleAttachmentRoles :: Maybe DA.Value
    , _IdentityPoolRoleAttachmentIdentityPoolId :: Text
    , _IdentityPoolRoleAttachmentRoleMappings :: Maybe DA.Value
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 23 } ''RulesConfigurationType)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''RoleMapping)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''MappingRule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 27 } ''IdentityPoolRoleAttachment)

resourceJSON :: IdentityPoolRoleAttachment -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Cognito::IdentityPoolRoleAttachment" :: Text), "Properties" .= a ]
