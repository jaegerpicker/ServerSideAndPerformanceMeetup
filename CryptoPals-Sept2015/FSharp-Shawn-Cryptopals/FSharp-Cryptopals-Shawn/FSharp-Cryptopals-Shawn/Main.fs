namespace FSharp_Cryptopals_Shawn
open System
open AppKit

module main =
    [<EntryPoint>]
    let main args =
        NSApplication.Init ()
        let app = NSApplication.SharedApplication
        app.Delegate <- new AppDelegate ()
        app.Run ()
        0
