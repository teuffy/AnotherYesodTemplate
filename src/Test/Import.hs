module Test.Import
( module X
, module Test.Import
) where

{- For pure convenience import this in your test modules -}

import Import               as X hiding (get, runDB, loadConfig)
import Database.Persist.Sql as X hiding (get, loadConfig)
import Yesod.Test           as X
import Test.Hspec           as X (hspec)
import Yesod.Default.Config as X
import Main                 as X hiding (main)

{- Commonly used.. -}
type Spec = YesodSpec App
type Example = YesodExample App

runDB:: SqlPersistM a -> Example a
runDB query = do
    pool <- connPool <$> getTestYesod
    liftIO $ runSqlPersistMPool query pool