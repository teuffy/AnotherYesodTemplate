{-# LANGUAGE QuasiQuotes, TypeFamilies, GeneralizedNewtypeDeriving, FlexibleContexts #-}
{-# LANGUAGE TemplateHaskell, OverloadedStrings, GADTs, MultiParamTypeClasses #-}
module Foundation where

import Yesod
import Database.Persist.Sqlite
import Control.Monad.Trans.Resource (runResourceT)
import Control.Monad.Logger (runStderrLoggingT)
import Network.HTTP.Conduit (Manager, newManager)
import Data.Default (def)


import Components.StaticFiles
import Components.Routes
import Components.Application
import Components.Persistent
import Components.Config
import Components.Yesod

openConnectionCount :: Int
openConnectionCount = 10

{- creates the app (of type App) -}
startApp = do
    httpMan <- newManager def
    pool <- createSqlitePool "test.db3" openConnectionCount
    runResourceT $ runStderrLoggingT $ flip runSqlPool pool $ do
                    runMigration migrateAll
                    insert $ Person "Michael" "Snoyman" 26
    s <- staticSite
    return $ App pool s httpMan

