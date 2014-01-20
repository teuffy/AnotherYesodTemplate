{-# LANGUAGE GADTs,  FlexibleContexts #-}
module Components.Persistent where

import Yesod
import Database.Persist.Sqlite
import Components.Application

instance YesodPersist App where
    type YesodPersistBackend App = SqlPersistT

    runDB action = do
        App pool _ _ <- getYesod
        runSqlPool action pool

{- Declare Database structure -}
share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Person
    firstName String
    lastName String
    age Int Gt Desc
    deriving Show
User
    name String
    deriving Show
|]
