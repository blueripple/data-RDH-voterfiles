{-# LANGUAGE CPP #-}
{-# LANGUAGE FlexibleContexts     #-}
{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE TypeOperators        #-}
{-# LANGUAGE ScopedTypeVariables  #-}
{-# OPTIONS_GHC -O0 -freduction-depth=0 #-}

module BlueRipple.Data.RDH_Voterfiles
  (
    module BlueRipple.Data.RDH_Voterfiles
  , module BlueRipple.Data.RDH_Voterfiles_Frames
  )
where

import qualified BlueRipple.Data.RDH_Voterfiles_Frames as VF
import BlueRipple.Data.RDH_Voterfiles_Frames
import qualified BlueRipple.Data.LoadersCore as BR
import qualified BlueRipple.Data.CachingCore as BR

import qualified Frames                        as F

import qualified Knit.Report as K

#if MIN_VERSION_streamly(0,8,0)

#else
import qualified Streamly as Streamly
import qualified Streamly.Internal.Prelude as Streamly
#endif

type VoterFileR = F.RecordColumns VF.VF_Raw

voterfileByTracts' :: (K.KnitEffects r, BR.CacheEffects r)
                  => BR.DataPath
                  -> Maybe Text
                  -> K.Sem r (K.ActionWithCacheTime r (F.Frame VF.VF_Raw))
voterfileByTracts' dataPath mCacheKey =
  let cacheKey = fromMaybe "RDH_voterfilesByTract2022.bin" mCacheKey
  in BR.cachedFrameLoader dataPath Nothing Nothing id Nothing cacheKey

voterfileByTracts :: (K.KnitEffects r, BR.CacheEffects r)
                  => Maybe Text
                  -> K.Sem r (K.ActionWithCacheTime r (F.Frame VF.VF_Raw))
voterfileByTracts = voterfileByTracts' (BR.LocalData $ toText VF.voterfileByTract2022CSV)
