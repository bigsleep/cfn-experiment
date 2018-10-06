{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Budgets.Budget
    ( Spend(..)
    , Subscriber(..)
    , BudgetData(..)
    , Notification(..)
    , TimePeriod(..)
    , CostTypes(..)
    , NotificationWithSubscribers(..)
    , Budget(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Spend = Spend
    { _SpendAmount :: Double
    , _SpendUnit :: Text
    } deriving (Show, Eq)

data Subscriber = Subscriber
    { _SubscriberSubscriptionType :: Text
    , _SubscriberAddress :: Text
    } deriving (Show, Eq)

data BudgetData = BudgetData
    { _BudgetDataBudgetLimit :: Maybe Spend
    , _BudgetDataTimePeriod :: Maybe TimePeriod
    , _BudgetDataTimeUnit :: Text
    , _BudgetDataBudgetName :: Maybe Text
    , _BudgetDataBudgetType :: Text
    , _BudgetDataCostTypes :: Maybe CostTypes
    , _BudgetDataCostFilters :: Maybe DA.Value
    } deriving (Show, Eq)

data Notification = Notification
    { _NotificationThresholdType :: Maybe Text
    , _NotificationComparisonOperator :: Text
    , _NotificationThreshold :: Double
    , _NotificationNotificationType :: Text
    } deriving (Show, Eq)

data TimePeriod = TimePeriod
    { _TimePeriodStart :: Maybe Text
    , _TimePeriodEnd :: Maybe Text
    } deriving (Show, Eq)

data CostTypes = CostTypes
    { _CostTypesUseAmortized :: Maybe Bool
    , _CostTypesIncludeRecurring :: Maybe Bool
    , _CostTypesUseBlended :: Maybe Bool
    , _CostTypesIncludeSupport :: Maybe Bool
    , _CostTypesIncludeDiscount :: Maybe Bool
    , _CostTypesIncludeSubscription :: Maybe Bool
    , _CostTypesIncludeRefund :: Maybe Bool
    , _CostTypesIncludeUpfront :: Maybe Bool
    , _CostTypesIncludeOtherSubscription :: Maybe Bool
    , _CostTypesIncludeTax :: Maybe Bool
    , _CostTypesIncludeCredit :: Maybe Bool
    } deriving (Show, Eq)

data NotificationWithSubscribers = NotificationWithSubscribers
    { _NotificationWithSubscribersNotification :: Notification
    , _NotificationWithSubscribersSubscribers :: [Subscriber]
    } deriving (Show, Eq)

data Budget = Budget
    { _BudgetBudget :: BudgetData
    , _BudgetNotificationsWithSubscribers :: Maybe [NotificationWithSubscribers]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Spend)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''Subscriber)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''BudgetData)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''Notification)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''TimePeriod)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''CostTypes)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 28 } ''NotificationWithSubscribers)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Budget)

resourceJSON :: Budget -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Budgets::Budget" :: Text), "Properties" .= a ]
