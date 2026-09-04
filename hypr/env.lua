-- nvidia --

--hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "iHD")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("GSK_RENDERER", "ngl")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GL_GSYNC_ALLOWED", "1")
--(prime)--
hl.env("__NV_PRIME_RENDER_OFFLOAD", "1")
hl.env("__VK_LAYER_NV_optimus", "NVIDIA_only")
-- hl.env("WLR_DRM_NO_ATOMIC", "1")
hl.env("__GL_MaxFramesAllowed", "1")
-- hl.env("__GL_SYNC_TO_VBLANK", "0")
hl.env("__GL_VRR_ALLOWED", "1")
--hl.env("MESA_VK_DEVICE_SELECT", "8086:a7a8")
hl.env("MESA_VK_DEVICE_SELECT", "10de:28a0")
-- hl.env("LIBGL_ALWAYS_SOFTWARE", "1")
-- hl.env("WLR_RENDER_ALLOW_SOFTWARE", "1")
-- hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
hl.env("EGL_PLATFORM", "wayland")
-- proton?!
hl.env("PROTON_ENABLE_NGX_UPDATER", "1")

-- aquamarine stuff --

hl.env("AQ_DRM_DEVICES", "/dev/dri/card0:/dev/dri/card1")
-- hl.env("AQ_MGPU_NO_EXPLICIT", "1")
-- hl.env("AQ_NO_MODIFIERS", "1")
hl.env("AQ_FORCE_LINEAR_BLIT", "0")

-- hyprland cursors --

hl.env("HYPRCURSOR_THEME", "Win10OS-cursors")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "/home/pepushi/.icons/Win10OS-cursors/cursors")
hl.env("XCURSOR_SIZE", "24")

-- toolkit backend --

hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("CLUTTER_BACKEND", "wayland")

-- qt crap --
-- hl.env("QT_QUICK_CONTROLS_STYLE","org.hyprland.style")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
-- hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
-- hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_QPA_PLATFORMTHEME", "qtengine")

-- set firefox & electron to wayland --
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- hyprshot --
hl.env("HYPRSHOT_DIR", "/home/pepushi/Pictures/Screenshots/")

-- Because Terminal Management Sucks
hl.env("TERMINAL", "kitty")
