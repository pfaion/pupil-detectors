"""
(*)~---------------------------------------------------------------------------
Pupil - eye tracking platform
Copyright (C) 2012-2019 Pupil Labs

Distributed under the terms of the GNU
Lesser General Public License (LGPL v3.0).
See COPYING and COPYING.LESSER for license details.
---------------------------------------------------------------------------~(*)
"""
try:
    from .utils import Roi
    from .detector_base import DetectorBase
    from .detector_2d import Detector2D
    from .detector_3d import Detector3D
except ImportError as e:
    from ctypes.util import find_library
    if find_library("opencv_world345") is None:
        raise ImportError(
            "Hint: Make sure that OpenCV libraries can be found in the Path!"
        ) from e
    else:
        raise
