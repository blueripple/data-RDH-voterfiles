{-# LANGUAGE CPP #-}
{-# LANGUAGE FlexibleContexts     #-}
{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE TypeOperators        #-}
{-# LANGUAGE ScopedTypeVariables  #-}
{-# OPTIONS_GHC -O0 -freduction-depth=0 #-}

module BlueRipple.Data.RDH_Voterfiles
  (
    module BlueRipple.Data.RDH_Voterfiles
  )
where

import qualified BlueRipple.Data.RDH_Voterfiles_Frames as VF
--import qualified BlueRipple.Data.Types.Demographic as DT
--import qualified BlueRipple.Data.Types.Geographic as GT
--import qualified BlueRipple.Data.Small.DataFrames as BR
import qualified BlueRipple.Data.LoadersCore as BR
--import qualified BlueRipple.Data.Small.Loaders as BR
--import qualified BlueRipple.Data.Keyed as BR
import qualified BlueRipple.Data.CachingCore as BR
--import qualified BlueRipple.Data.FramesUtils as BRF

import qualified Frames                        as F

{-
import qualified Control.Foldl                 as FL
import qualified Data.Map                      as M
import qualified Data.Text                     as T
import qualified Data.Vinyl                    as V
import           Data.Vinyl.TypeLevel                     (type (++))
import qualified Data.Vinyl.TypeLevel          as V
import           Data.Vinyl.Lens               (type (⊆))
import qualified Frames.Streamly.InCore        as FI
import qualified Frames.Melt                   as F
import qualified Numeric

import qualified Frames.Folds                  as FF
import qualified Frames.MapReduce              as FMR
import qualified Frames.Transform              as FT
import qualified Frames.SimpleJoins            as FJ
--import qualified Frames.Streamly.InCore        as FStreamly
import qualified Frames.Streamly.Transform     as FStreamly
-}
import qualified Knit.Report as K
--import qualified Knit.Utilities.Streamly as K

#if MIN_VERSION_streamly(0,8,0)

#else
import qualified Streamly as Streamly
import qualified Streamly.Internal.Prelude as Streamly
#endif

type VoterFileR = F.RecordColumns VF.VF_Raw

voterfileByTracts :: (K.KnitEffects r, BR.CacheEffects r)
                  => BR.DataPath
                  -> Maybe Text
                  -> K.Sem r (K.ActionWithCacheTime r (F.Frame VF.VF_Raw))
voterfileByTracts dataPath mCacheKey =
  let cacheKey = fromMaybe "RDH_voterfilesByTract2022.bin" mCacheKey
  in BR.cachedFrameLoader dataPath Nothing Nothing id Nothing cacheKey
