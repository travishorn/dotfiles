import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Util.Run
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
myBorderWidth   = 1

-- Which modkey to use
-- mod1Mask = left alt
-- mod3Mask = right alt
-- mod4Mask = windows key
myModMask       = mod1Mask

-- Number of workspaces
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#444444"
myFocusedBorderColor = "#007acc"

-- Key bindings
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- Launch a terminal. Mod + Shift + Enter
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- Launch dmenu. Mod + p
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- Close focused window. Mod + Shift + c
    , ((modm .|. shiftMask, xK_c     ), kill)

    -- Move focus to the next window. Mod + j
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window. Mod + k
    , ((modm,               xK_k     ), windows W.focusUp)

    -- Move focus to the master window. Mod + m
    , ((modm,               xK_m     ), windows W.focusMaster)

    -- Make current window master. Mod + Enter
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap current window with next window. Mod + Shift + j
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown)

    -- Swap current window with previous window. Mod + Shift + k
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp)

    -- Shrink the master area. Mod + h
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area. Mod + l
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Increment the number of windows in the master area. Mod + ,
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area. Mod + .
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Quit xmonad. Mod + Shift + q
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad. Mod + q
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    ]
    ++

    -- Switch to workspace. Mod + 2 (or 3, 4, etc)
    -- Move window to workspace. Mod + Shift + 2
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-- Layouts

-- Gaps
mySpacing = spacingRaw False            -- False = gaps even on single window
                       (Border 5 5 5 5) -- Screen gaps. Top bot right left
                       True             -- Enable screen gap
                       (Border 5 5 5 5) -- Window gaps
                       True             -- Enable window gaps

myLayout = mySpacing $ avoidStruts $ tiled
  where
     -- Partitions the screen into two panes: master and stack
     tiled   = Tall nmaster delta ratio

     -- Number of windows in the master pane
     nmaster = 1

     -- Proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

-- Processes to start when xmonad starts
-- Start picom, set wallpaper with feh, start xmobar
myStartupHook = do
  spawnOnce "picom"
  spawnOnce "~/.fehbg"
  spawnOnce "xmobar"

main = xmonad $ docks defaults

-- Final configuration. Use defaults for anythning not set in this file.
defaults = def {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        keys               = myKeys,
        layoutHook         = myLayout
        startupHook        = myStartupHook
        --mouseBindings      = myMouseBindings,
        --manageHook         = myManageHook,
        --handleEventHook    = myEventHook,
        --logHook            = myLogHook,
    }

-- Help for the key bindings
help :: String
help = unlines ["Key Bindings:",
    "",
    "-- Launching & killing programs",
    "Alt + Shift + Enter  Launch terminal",
    "Alt + p              Launch dmenu",
    "Alt + Shift + c      Close/kill the focused window",
    "",
    "-- Changing focus",
    "Alt + j              Move focus to the next window",
    "Alt + k              Move focus to the previous window",
    "Alt + m              Move focus to the master window",
    "",
    "-- Moving windows",
    "Alt + Shift + j      Swap window with next window",
    "Alt + Shift + k      Swap window with previous window",
    "Alt + Enter          Make the focused window master",
    "",
    "-- Resizing the master/stack",
    "Alt + h              Shrink the master area",
    "Alt + l              Expand the master area",
    "Alt + ,              More windows in master area",
    "Alt + .              Less windows in master area",
    "",
    "-- Workspaces",
    "Alt + Shift + [1..9] Move window to workspace",
    "Alt + [1..9]         Switch to workSpace",
    "",
    "-- Quit and restart",
    "Alt + q              Restart xmonad",
    "Alt + Shift + q      Quit xmonad"]
