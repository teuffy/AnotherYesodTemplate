module Components.StaticFiles where

import Prelude
import Yesod.Static
import qualified Yesod.Static as Static
import Components.Routes
import Components.Config
import Language.Haskell.TH (Q, Exp, Name)
import Data.Default (def)
import Yesod.Default.Util
import System.FilePath ((</>))



-- | use this to create your static file serving site
staticSite :: IO Static.Static
staticSite = if development then Static.staticDevel staticDir
                            else Static.static      staticDir

-- | This generates easy references to files in the static directory at compile time,
--   giving you compile-time verification that referenced files exist.
--   Warning: any files added to your static directory during run-time can't be
--   accessed this way. You'll have to use their FilePath or URL to access them.
$(staticFiles staticDir)

-- The following two functions can be used to combine multiple CSS or JS files
-- at compile time to decrease the number of http requests.
-- Sample usage (inside a Widget):
--
-- > $(combineStylesheets 'StaticR [style1_css, style2_css])
combineStylesheets :: Name -> [Route Static] -> Q Exp
combineStylesheets = combineStylesheets' development def

combineScripts :: Name -> [Route Static] -> Q Exp
combineScripts = combineScripts' development def

widgetFile :: String -> Q Exp
widgetFile = (if development then widgetFileReload
                             else widgetFileNoReload)
             def