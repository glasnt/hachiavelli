{-# LANGUAGE OverloadedStrings #-}

module Controllers.Home ( home ) where

import           Views.Home  (homeView)
import           Web.Scotty
import           Views.Utils


import qualified Data.Text.Lazy as T
import qualified Web.Scotty as S


home :: ScottyM ()
home = get "/" $ do
    m <- param "metric" --maybeParam "metric"
    homeView m

 
--maybeParam :: S.Parsable a => T.Text -> S.ActionM (Maybe a)
--maybeParam name = S.rescue (S.param name >>= return . Just) (\_ -> return Nothing)

