{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators #-}

module BlueRipple.Data.RDH_Voterfiles_Paths
  (
    module BlueRipple.Data.RDH_Voterfiles_Paths
  )
where
import qualified BlueRipple.Data.CachingCore as BRC
--import qualified Frames as F
import qualified Frames.Streamly.TH                     as FS
import qualified Frames.Streamly.ColumnUniverse         as FCU
import qualified Data.Text as T
import qualified Data.Map as M
import qualified Data.Set as S
import qualified Language.Haskell.TH.Env as Env

dataDir :: T.Text
dataDir = fromMaybe "../../bigData/RDH-Voterfiles/" $ ($$(Env.envQ "BR_RDH_VOTERFILE_DATA_DIR") :: Maybe String) >>= BRC.insureFinalSlash . toText

voterfileByTract2022CSV :: FilePath
voterfileByTract2022CSV = toString $ dataDir <> "voterfile_tracts_2022.csv"


voterfileByTract2022RowGenAC :: FS.RowGen
                                FS.DefaultStream
                                'FS.ColumnByName
                                FCU.CommonColumns
voterfileByTract2022RowGenAC = (FS.rowGen voterfileByTract2022CSV) { FS.tablePrefix = "VF"
                                                                   , FS.separator   = FS.CharSeparator ','
                                                                   , FS.rowTypeName = "VF_Raw"
                                                                   }

voterFileByTract2022RowGen ::  FS.RowGen
                               FS.DefaultStream
                               'FS.ColumnByName
                               FCU.CommonColumns
voterFileByTract2022RowGen = FS.modifyColumnSelector modF voterfileByTract2022RowGenAC
  where modF = FS.renameSomeUsingNames renames

renames :: Map FS.HeaderText FS.ColTypeName
renames = M.fromList [(FS.HeaderText "geoid", FS.ColTypeName "TractGeoId")]
