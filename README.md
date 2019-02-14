
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nsrr

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/muschellij2/nsrr.svg?branch=master)](https://travis-ci.com/muschellij2/nsrr)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/muschellij2/nsrr?branch=master&svg=true)](https://ci.appveyor.com/project/muschellij2/nsrr)
[![Coverage
status](https://codecov.io/gh/muschellij2/nsrr/branch/master/graph/badge.svg)](https://codecov.io/gh/muschellij2/nsrr)
<!-- badges: end -->

The goal of nsrr is to allow users to access data from the National
Sleep Research Resource (’NSRR’) (<https://sleepdata.org/>).

## Installation

You can install the released version of nsrr from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("nsrr")
```

## Token

To retrieve your NSRR token, go to <https://sleepdata.org/dashboard>,
and sign in. This token will allow you access to any data sets you have
requested access to. If you do not have access, then it will allow you
to download files that are publicly available.

Set the token by adding this to your `~/.Renviron` file:

``` r
NSRR_TOKEN="YOUR TOKEN GOES HERE"
```

The token is accessible via `token = Sys.getenv("NSRR_TOKEN")`. Each
`nsrr` function also has the argument `token` to pass through if you do
not wish to set it.

To determine if you are authenticated, you can use:

``` r
library(nsrr)
nsrr_auth()
$authenticated
[1] FALSE
```

## Examples

### NSRR data sets

Here is how you can access the NSRR datasets list:

``` r
library(nsrr)
df = nsrr_datasets()
DT::datatable(df)
```

<img src="man/figures/README-example-1.png" width="100%" />

### NSRR data set files

Here we first get a list of the files in the `datasets` sub-directory
from the `shhs` data set:

``` r
df = nsrr_dataset_files("shhs", path = "datasets")
head(df)
  dataset                         full_path    folder
1    shhs                  datasets/archive datasets/
2    shhs    datasets/eeg-spectral-analysis datasets/
3    shhs             datasets/hrv-analysis datasets/
4    shhs             datasets/CHANGELOG.md datasets/
5    shhs           datasets/KNOWNISSUES.md datasets/
6    shhs datasets/shhs1-dataset-0.13.0.csv datasets/
                 file_name is_file file_size
1                  archive   FALSE         0
2    eeg-spectral-analysis   FALSE         0
3             hrv-analysis   FALSE         0
4             CHANGELOG.md    TRUE     10175
5           KNOWNISSUES.md    TRUE     11284
6 shhs1-dataset-0.13.0.csv    TRUE  24305606
                 file_checksum_md5 archived
1                             <NA>    FALSE
2                             <NA>    FALSE
3                             <NA>    FALSE
4 1432504de974e712e1cd7d99038bdfd5    FALSE
5 c53ea822afa2e78ba601da508562775d    FALSE
6 212cf854c1e04ce6d75cb6580917e3a9    FALSE
```

### Downloading NSRR data set files

We can then download the `CHANGELOG.md` file as it’s publicly
accessible.

``` r
url = nsrr_download_url("shhs", path = "datasets/CHANGELOG.md")
# print URL
dl = nsrr_download_file("shhs", path = "datasets/CHANGELOG.md")
dl$outfile
[1] "/var/folders/1s/wrtqcpxn685_zk570bnx9_rr0000gr/T//Rtmpe4m2MV/file4b0019075bdd.md"
cat(readLines(dl$outfile), sep = "\n")
## 0.13.1 (December 20, 2017)

- Fix odd symbols in variable descriptions

## 0.13.0 (December 7, 2017)

- Add prevalent/incident AF indicators
- Update description of how vital (death) status was obtained
- The CSV datasets generated from a SAS export are located here:
  - `\\rfawin\bwh-sleepepi-shhs\nsrr-prep\_releases\0.13.0\`

## 0.12.0 (September 28, 2017)

- Rename primary subject identifier from 'obf_pptid' to 'nsrrid'
- Remove extraneous 'ecgdt' variable from SHHS1 dataset
- Clean up more variable display names, e.g. spell out abbreviations
- Improve display names and formulas for 'ahi_' variables
- The CSV datasets generated from a SAS export are located here:
  - `\\rfa01\bwh-sleepepi-shhs\nsrr-prep\_releases\0.12.0\`

## 0.11.1 (April 12, 2017)

- Add many new variable labels; remove extraneous labels
- Clarify `stonsetp` and `stloutp` units
- **Gem Changes**
  - Updated to spout 0.12.1

## 0.11.0 (January 12, 2017)

- Replace SHHS1 HRV dataset file, fixes outlier and IHR miscalculation
- The CSV datasets generated from a SAS export are located here:
  - `\\rfa01\bwh-sleepepi-shhs\nsrr-prep\_releases\0.11.0\`

## 0.10.1 (December 29, 2016)

- Fix variable units in HRV Analysis folder (seconds -> milliseconds)

## 0.10.0 (December 2, 2016)

- Add 'icsd' tag to many AHI variables
- Add HRV analysis datasets
- The CSV datasets generated from a SAS export are located here:
  - `\\rfa01\bwh-sleepepi-shhs\nsrr-prep\_releases\0.10.0\`

## 0.9.0 (March 11, 2016)

- Added more meaningful descriptions for race and ethnicity variables
- Remove duplicated prevalent condition variables from CVD Summary dataset
- The CSV datasets generated from a SAS export is located here:
  - `\\rfa01\bwh-sleepepi-shhs\nsrr-prep\_releases\0.9.0\`
    - `shhs1-dataset-0.9.0.csv`
    - `shhs1-eeg-band-summary-dataset-0.9.0.csv`
    - `shhs1-eeg-spectral-summary-dataset-0.9.0.csv`
    - `shhs-interim-followup-dataset-0.9.0.csv`
    - `shhs2-dataset-0.9.0.csv`
    - `shhs2-eeg-band-summary-dataset-0.9.0.csv`
    - `shhs2-eeg-spectral-summary-dataset-0.9.0.csv`
    - `shhs-cvd-dataset-0.9.0.csv`
    - `shhs-cvd-events-dataset-0.9.0.csv`
- **Gem Changes**
  - Updated to spout 0.11.1

## 0.8.2 (February 4, 2016)

- Remove extraneous `\r\r` from variable display names
- Add labels for key hypertension variables
- Clean up labels and description for blood draw variables
- Fix misspellings of `myocardial`
- Add descriptions for ECG variable set
- Fix errant domains for some ECG variables
- Clarify variables describing ankle-arm blood pressure

## 0.8.1 (January 19, 2016)

- Fixed naming convention of "Physical Measurements, Blood Pressure, Ankle-Arm Index, ECG (SHHS2)" form
- **Gem Changes**
  - Updated to spout 0.11.0
  - Updated to Ruby 2.3.0

## 0.8.0 (December 9, 2015)

- Remove extraneous variables from SHHS2 dataset
- Remove `stent_date` variable from CVD dataset -- did not contain any data
- Added new Apnea-Hypopnea Indices for ICSD-3 coding (`ahi_*` variables)
- Rename `mi` variable in Interim Follow-up dataset
- Updated `noyes01` domain to remove extraneous option
- The CSV datasets generated from a SAS export is located here:
  - `\\rfa01\bwh-sleepepi-shhs\nsrr-prep\_releases\0.8.0.rc\`
    - `shhs1-dataset-0.8.0.csv`
    - `shhs1-eeg-band-summary-dataset-0.8.0.csv`
    - `shhs1-eeg-spectral-summary-dataset-0.8.0.csv`
    - `shhs-interim-followup-dataset-0.8.0.csv`
    - `shhs2-dataset-0.8.0.csv`
    - `shhs2-eeg-band-summary-dataset-0.8.0.csv`
    - `shhs2-eeg-spectral-summary-dataset-0.8.0.csv`
    - `shhs-cvd-dataset-0.8.0.csv`
    - `shhs-cvd-events-dataset-0.8.0.csv`

## 0.7.0 (June 25, 2015)

- Spectral analysis variables have been added to the dataset for both SHHS Visit 1 and SHHS Visit 2
- Additional cardiovascular disease outcome variables have been added to the dataset
- The CSV datasets generated from a SAS export is located here:
  - `\\rfa01\bwh-sleepepi-shhs\nsrr-prep\_releases\0.7.0\`
    - `shhs1-dataset-0.7.0.rsv`
    - `shhs1-eeg-band-summary-dataset-0.7.0.csv`
    - `shhs1-eeg-spectral-summary-dataset-0.7.0.csv`
    - `shhs-interim-followup-dataset-0.7.0.csv`
    - `shhs2-dataset-0.7.0.csv`
    - `shhs2-eeg-band-summary-dataset-0.7.0.csv`
    - `shhs2-eeg-spectral-summary-dataset-0.7.0.csv`
    - `shhs-cvd-dataset-0.7.0.csv`
    - `shhs-cvd-events-dataset-0.7.0.csv`
- **Gem Changes**
  - Updated to spout 0.10.2

## 0.6.0 (December 5, 2014)

- The interim dataset has been pared down to only include individuals who consented to have their data shared
- Identifiable ages (age > 89) have been recoded as 90 years old in the dataset
  - Categorical age variables were not affected by the change
- The CSV datasets generated from a SAS export is located here:
  - `\\rfa01\bwh-sleepepi-shhs\nsrr-prep\_releases\0.6.0\`
    - `shhs1-dataset-0.6.0.csv`
    - `shhs-interim-followup-dataset-0.6.0.csv`
    - `shhs2-dataset-0.6.0.csv`
    - `shhs-cvd-dataset-0.6.0.csv`
- **Gem Changes**
  - Updated to spout 0.10.1

## 0.5.0 (November 28, 2014)

- Created Interim variables, domains, and units for the 'Exam Cycle 2' dataset
- `visitnumber` has been added as a variable to the Interim dataset to allow for graphs and images on www.sleepdata.org
- Spelling mistakes have been largely corrected in the interim followup dataset
- PSG quality variables have been added to the SHHS1 and SHHS2 datasets
- The CSV datasets generated from a SAS export is located here:
  - `\\rfa01\bwh-sleepepi-shhs\nsrr-prep\_releases\0.5.0\`
    - `shhs1-dataset-0.5.0.csv`
    - `shhs-interim-followup-dataset-0.5.0.csv`
    - `shhs2-dataset-0.5.0.csv`
    - `shhs-cvd-dataset-0.5.0.csv`
- **Gem Changes**
  - Updated to spout 0.10.0

## 0.4.4 (November 10, 2014)

- **Gem Changes**
  - Updated to spout 0.10.0.rc3
  - Use of Ruby 2.1.4 is now recommended

## 0.4.3 (October 6, 2014)

- Created SHHS2 medications form and linked corresponding variables
- Fixed misspellings of minimum
- Added tests to assure that display names didn't exceed 255 characters
- **Gem Changes**
  - Updated to spout 0.9.0.rc

## 0.4.2 (September 29, 2014)

- **Gem Changes**
  - Use of Ruby 2.1.3 is now recommended

## 0.4.1 (July 28, 2014)

- Key desaturation variables have been labeled with `hypoxia` and `hypoxemia` to allow for easy searching on sleepdata.org
- Medication variables have been updated with labels for related diseases
- Calculations have been added to BMI variables that list the appropriate component height and weight variables
- **Gem Changes**
  - Updated to spout 0.9.0.beta1

## 0.4.0 (July 3, 2014)

- Removed data for subjects who did not consent to share their data
- The CSV datasets generated from a SAS export is located here:
  - `\\rfa01\bwh-sleepepi-shhs\nsrr-prep\_releases\0.4.0\`
    - `shhs1-dataset-0.4.0.csv`
    - `shhs2-dataset-0.4.0.csv`
    - `shhs-cvd-dataset-0.4.0.csv`
- **Gem Changes**
  - Updated to spout 0.8.0
- Issues with data from the BioLINCC datasets for v0.4.0 (i.e. extreme values) have been grouped into a [Known Issues](https://github.com/sleepepi/shhs-data-dictionary/blob/master/KNOWNISSUES.md) list
- Added the following forms to variables
  - Health Interview (ARIC, CHS, Tucscon/Strong Heart)
  - Health Interview (Framingham)
  - Health Interview (New York)
  - PSG Scoring Notes
  - Health Interview (SHHS2)
  - Morning Survey (SHHS2)
  - Physical Measurements, Blood Pressure, Ankle-Arm Index, ECG
  - Quality of Life Survey (SF-36)

## 0.3.0 (June 20, 2014)

- Removed `in_shhs2_lad` variable (i.e. participant was part of SHHS2 Limited Access Dataset) as it is no longer relevant
- **Gem Changes**
  - Use of Ruby 2.1.2 is now recommended
  - Updated to spout 0.8.0.rc2
- The CSV datasets generated from a SAS export is located here:
  - `\\rfa01\bwh-sleepepi-shhs\nsrr-prep\_releases\0.3.0\`
    - `shhs1-dataset-0.3.0.csv`
    - `shhs2-dataset-0.3.0.csv`
    - `shhs-cvd-dataset-0.3.0.csv`
- The SAS export now adds race, gender, and age at SHHS1 to each of the CSV datasets
  - Missing codes are now removed by default from all variables in SHHS1 and SHHS2
  - Null values (in the form of zeroes) are now removed from variables where appropriate
- Valid race domain choices were changed to be White, Black, and Other
- Valid gender values were updated from characters to numeric values for consistency across other domains
- Ethnicity has been added as a separate variable, rather than being classified within the race domain
- Visit number has been re-added to each of the BioLINCC datasets
- Categorical age has been added to SHHS1 and SHHS2 BioLINCC datasets
  - Categorical age at SHHS1 has been added to the SHHS2 dataset
- The obfuscated pptid has now been added to all datasets by default as `obf_pptid`
- Issues with data from the BioLINCC datasets for v0.3.0 (i.e. extreme values) have been grouped into a [Known Issues](https://github.com/sleepepi/shhs-data-dictionary/blob/master/KNOWNISSUES.md) list

## 0.2.0 (March 24, 2014)

- The CSV dataset generated from a SAS export is located here:
  - `\\rfa01\bwh-sleepepi-shhs\nsrr-prep\_releases\0.2.0\`
    - `shhsall-0.2.0.csv`- Moved `commonly_used` to the root of the json variable object
- Changed references of `patient` and `pt` to `participant`
- Cleaned up and removed assignment statements from calculations
- Changed description references of `#` to spelled out `number`
- Added forms JSON files and tests for variables to be able to reference the forms on which they exist
- **Gem Changes**
  - Use of Ruby 2.1.1 is now recommended
  - Updated to spout 0.7.0.beta3

## 0.1.0 (July 26, 2013)

### Changes
- The 0.1.0 branch corresponds with the Sleep Portal 0.15.0 release branch
- The SHHS SAS and SQL dataset have been cleaned to match up with the variables and domains in the SHHS Data Dictionary
  - The SQL dataset is located here:
    - `\\rfa01\bwh-sleepepi-shhs\shhs\sleep-portal-integration\_imports\2013-07-25_v0_1_0`
      - `shhs_20130725.sql`
```

### Listing All NSRR data set files

To list all the files, recursively, you would run:

``` r
nsrr_all_dataset_files("shhs")
```

but it may take some time.
