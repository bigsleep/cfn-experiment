module Main where

import CFn (Specification)
import qualified Data.ByteString.Lazy as BSL (toStrict)
import Network.HTTP.Client
import Network.HTTP.Client.TLS
import Network.HTTP.Types.Status (statusCode)

import Data.Aeson (eitherDecodeStrict)

main :: IO ()
main = do
  manager <- newManager tlsManagerSettings

  request <- parseRequest "https://d33vqc0rt9ld30.cloudfront.net/latest/gzip/CloudFormationResourceSpecification.json"
  response <- httpLbs request manager

  putStrLn $ "The status code was: " ++ show (statusCode $ responseStatus response)
  let x = eitherDecodeStrict . BSL.toStrict $ responseBody response
  print (x :: Either String Specification)
