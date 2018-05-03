cmake_minimum_required( VERSION 2.8 )
project ( calibrate_stereo )

set( CMAKE_CXX_COMPILER "g++" )
# set( CMAKE_BUILD_TYPE "Release" )
set( CMAKE_BUILD_TYPE "Debug" )
set( CMAKE_CXX_FLAGS "-std=c++11 -march=native -O3" )

find_package( OpenCV REQUIRED )
find_package( PCL REQUIRED )
ADD_DEFINITIONS( ${PCL_DEFINITIONS} )

include_directories( ${OpenCV_INCLUDE_DIRS} ${PCL_INCLUDE_DIRS} )

set( THIRD_PARTY_LIBS
    ${OpenCV_LIBS}
    ${PCL_LIBRARIES}
)

add_executable(stereo_match stereo_match.cpp)
target_link_libraries(stereo_match ${THIRD_PARTY_LIBS})

add_executable(stereo_calib stereo_calib.cpp)
target_link_libraries(stereo_calib ${THIRD_PARTY_LIBS})
