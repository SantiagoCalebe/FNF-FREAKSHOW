package states;

import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.addons.display.FlxBackdrop;
import flixel.ui.FlxButton;

class ErrorState extends MusicBeatState {
    public static var leftState:Bool = false;

    var warnText:FlxText;
    var checker:FlxBackdrop;
    var link1:FlxButton;
    var link2:FlxButton;
    var link3:FlxButton;

    override function create() {
        super.create();

        // Background
        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        add(bg);

        // Checker backdrop
        checker = new FlxBackdrop(Paths.image("grid/Grid_lmao"));
        checker.scrollFactor.set(0, 0);
        checker.alpha = 0.1;
        add(checker);

        // Warning text
        warnText = new FlxText(0, 0, FlxG.width,
            "Uh, oh..\n\nUnrecorded Tapes crashed unexpectedly.\nPlease report this issue to GitHub.",
            32);
        warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
        warnText.screenCenter(Y);
        add(warnText);

        // Buttons
        link1 = createButton("Report to GitHub.", warnText.y + 100, function() {
            FlxG.camera.flash(FlxColor.WHITE, 0.33);
            FlxG.sound.play(Paths.sound("confirmMenu"));
            CoolUtil.browserLoad("https://github.com/santiagocalebe/unrecordedtapes/issues");
        });

        link2 = createButton("Restart the game (May not work)", link1.y + 100, function() {
            TitleState.initialized = false;
            TitleState.closedState = false;
            FlxG.sound.music.fadeOut(0.3);
            if (FreeplayState.vocals != null) {
                FreeplayState.vocals.fadeOut(0.3);
                FreeplayState.vocals = null;
            }
            FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function() FlxG.resetGame(), false);
        });

        link3 = createButton("Close the game.", link2.y + 100, function() {
            FlxG.camera.fade(FlxColor.BLACK);
            #if DISCORD_ALLOWED
            DiscordClient.shutdown();
            #end
            Sys.exit(1);
        });
    }

    function createButton(label:String, y:Float, callback:Void -> Void):FlxButton {
        var btn = new FlxButton(0, 0, label, callback);
        btn.screenCenter();
        btn.y = y;
        btn.scale.set(2, 2);
        add(btn);
        return btn;
    }

    override function update(elapsed:Float) {
        checker.x += 0.5 * (elapsed / (1 / 120));
        checker.y -= 0.16;

        super.update(elapsed);
    }
}
