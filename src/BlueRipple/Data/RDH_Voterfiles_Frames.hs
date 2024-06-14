{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE TemplateHaskell     #-}
{-# LANGUAGE TypeApplications    #-}

module BlueRipple.Data.RDH_Voterfiles_Frames
  ( module BlueRipple.Data.RDH_Voterfiles_Paths
  , module BlueRipple.Data.RDH_Voterfiles_Frames
  )
where

import           BlueRipple.Data.RDH_Voterfiles_Paths
import qualified Frames.Streamly.TH                     as F

F.tableTypes' voterFileByTract2022RowGen
