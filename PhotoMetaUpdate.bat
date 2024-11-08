@echo off
setlocal enabledelayedexpansion

:: Set the directory where your photos are located (current directory)
set "PHOTO_DIR=%cd%"

:: Define the location information for metadata suffix
set "LOCATION_SUFFIX=network-service-abhayapuri"

:: Custom Description for ImageDescription
set "DESCRIPTION=Specializing in computers, CCTV cameras, printers, parts, Sale & Repair"

:: Custom Author for Artist metadata
set "AUTHOR=Akramul Jakir"

:: Custom Copyright text
set "COPYRIGHT=© 2024 Network Service"

:: Custom XP Author (For XPAuthor metadata)
set "XP_AUTHOR=Network Service"

:: Custom XP Comment (For XPComment metadata)
set "XP_COMMENT=Kalaparishad Market, Abhayapuri, Assam, India - Contact: +91 8876996996"

:: Custom Keywords for metadata (separated by commas)
set "KEYWORDS=Network Service, Electronics, Computer Repair, CCTV, Abhayapuri, Assam, India"

:: Website URL
set "WEBSITE=www.networkservice.in"

:: GPS coordinates for the image
set "LATITUDE=26.3330354"
set "LONGITUDE=90.670464"

:: Path to ExifTool executable
set "EXIFTOOL_PATH=C:\ExifTool\exiftool.exe"

:: Create the seo subdirectory if it doesn't exist
if not exist "%PHOTO_DIR%\seo" (
    mkdir "%PHOTO_DIR%\seo"
)

:: Rating value to set
set "RATING=5"

:: Loop through all image files in the folder
for %%f in ("%PHOTO_DIR%\*.jpg" "%PHOTO_DIR%\*.jpeg" "%PHOTO_DIR%\*.png" "%PHOTO_DIR%\*.gif" "%PHOTO_DIR%\*.bmp") do (
    echo Processing %%f...

    :: Construct the new file name with the original name + suffix
    set "NEW_NAME=%%~nf_%LOCATION_SUFFIX%%%~xf"

    :: Check if a file with the new name already exists in the seo subdirectory
    if exist "%PHOTO_DIR%\seo\!NEW_NAME!" (
        echo Duplicate file name exists: !NEW_NAME!
        echo Skipping !NEW_NAME!
    ) else (
        :: Create a copy of the original file and rename the copy in the seo folder
        copy "%%f" "%PHOTO_DIR%\seo\!NEW_NAME!"
        echo Copied and renamed to: !NEW_NAME!

        :: Update the title metadata for the newly copied file in the seo folder
        "%EXIFTOOL_PATH%" -overwrite_original -XMP:Title="%%~nf_%LOCATION_SUFFIX%" "%PHOTO_DIR%\seo\!NEW_NAME!"
        echo Title metadata updated for: !NEW_NAME!

        :: Update the description (ImageDescription) metadata for the newly copied file
        "%EXIFTOOL_PATH%" -overwrite_original -ImageDescription="%DESCRIPTION%" "%PHOTO_DIR%\seo\!NEW_NAME!"
        echo Description metadata updated for: !NEW_NAME!

        :: Update the author metadata (Artist) for the newly copied file
        "%EXIFTOOL_PATH%" -overwrite_original -Artist="%AUTHOR%" "%PHOTO_DIR%\seo\!NEW_NAME!"
        echo Author metadata updated for: !NEW_NAME!

        :: Update the copyright metadata
        "%EXIFTOOL_PATH%" -overwrite_original -Copyright="%COPYRIGHT%" "%PHOTO_DIR%\seo\!NEW_NAME!"
        echo Copyright metadata updated for: !NEW_NAME!

        :: Update the XP Author metadata
        "%EXIFTOOL_PATH%" -overwrite_original -XPAuthor="%XP_AUTHOR%" "%PHOTO_DIR%\seo\!NEW_NAME!"
        echo XP Author metadata updated for: !NEW_NAME!

        :: Update the XP Comment metadata
        "%EXIFTOOL_PATH%" -overwrite_original -XPComment="%XP_COMMENT%" "%PHOTO_DIR%\seo\!NEW_NAME!"
        echo XP Comment metadata updated for: !NEW_NAME!

        :: Update the Keywords metadata
        "%EXIFTOOL_PATH%" -overwrite_original -Keywords="%KEYWORDS%" "%PHOTO_DIR%\seo\!NEW_NAME!"
        echo Keywords metadata updated for: !NEW_NAME!

        :: Add Website to the XPComment metadata (optional)
        "%EXIFTOOL_PATH%" -overwrite_original -XPComment="%XP_COMMENT% - Website: %WEBSITE%" "%PHOTO_DIR%\seo\!NEW_NAME!"
        echo Website metadata updated for: !NEW_NAME!

        :: Add GPS data to the metadata
        "%EXIFTOOL_PATH%" -overwrite_original -GPSLatitude=%LATITUDE% -GPSLatitudeRef=N -GPSLongitude=%LONGITUDE% -GPSLongitudeRef=E "%PHOTO_DIR%\seo\!NEW_NAME!"
        echo GPS metadata updated for: !NEW_NAME!

        :: Update the Rating metadata (set to 5)
        "%EXIFTOOL_PATH%" -overwrite_original -Rating=%RATING% "%PHOTO_DIR%\seo\!NEW_NAME!"
        echo Rating metadata updated for: !NEW_NAME!
    )
)

echo Copying, renaming, and metadata updates (Title, Description, Author, Copyright, XP Author, XP Comment, Keywords, Website, GPS, Rating) completed for all images.
pause
exit /b
