module Components.Yesod where

import Yesod
import Components.Application
import Components.Routes
import Components.StaticFiles
import Components.Config

import Control.Monad (when)
import Text.Hamlet

instance Yesod App where
    defaultLayout widget = do
        master <- getYesod
        mmsg <- getMessage

        pc <- widgetToPageContent $ do
            addScript $ StaticR jquery_jquery_min_js
            addStylesheet $ StaticR bootstrap_css_bootstrap_css
            addScript $ StaticR bootstrap_js_bootstrap_js
            when jasmineActivate $ do
                $(combineScripts 'StaticR
                    [ jasmine_jasmine_js
                    , jasmine_jasmine_html_js
                    , jasmine_boot_js
                    ])
                addStylesheet $ StaticR jasmine_jasmine_css
            widget
        giveUrlRenderer $(hamletFile "templates/layout.hamlet")