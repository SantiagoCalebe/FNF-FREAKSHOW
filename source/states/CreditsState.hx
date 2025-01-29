package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.addons.display.FlxBackdrop;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class CreditsState extends MusicBeatState {
    private var creditsText:FlxText;
	private var instructionsText:FlxText;
    private var instructionsText2:FlxText;
    private var scrollSpeed:Float = 120;
	//private var acceleratedScrollSpeed:Float = 120;
	var checker:FlxBackdrop;
    var ving:FlxSprite;

    override public function create():Void {
        super.create();

		checker = new FlxBackdrop(Paths.image('grid/Grid_lmao'));
		//checker.velocity.set(112, 110);
		checker.updateHitbox();
		checker.scrollFactor.set(0, 0);
		checker.alpha = 0.2;
		checker.screenCenter(X);
		add(checker);

        creditsText = new FlxText(0, FlxG.height, FlxG.width, 
			//First credit shit
            "FNF' FREAKYSHOW \n\n\n\n\n\n\n" +

			//The good part lol
            "A NOT so innocent DEMO CREW: \n\n\n\n\n\n\n\n\n\n\n\n" +

			//People
            "MikeDEV \nOwner, artist and Composer. \n\n\n" +
            "Santiago \nCo-Onwer, coder and artist. \n\n\n" +
				              "RedMaskOfficial \nArtist and Wallpaper Art. \n\n\n" +
			"Catly \nPlaytester. \n\n\n" +
			"FraserBear \nPlaytester. \n\n\n" +
			"CSNP \nComposer. \n\n\n" +
            "MattTheCool \nComposer. \n\n\n" +
            "ThatOneFourIhr \nComposer. \n\n\n" +
            "Kirill \nCharter. \n\n\n" +
            "Nico \nBanner Artist. \n\n\n\n\n" +

            "Special Thanks \n\n\n\n\n\n\n\n\n\n\n" +

            "PhantomStalks \nArtist. \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + 

			"Thank you for playing \nFNF' FREAKYSHOW, \nsee ya in next update.."
            
        );
        creditsText.setFormat("VCR OSD Mono", 64, FlxColor.WHITE, "center");
        add(creditsText);

        ving = new FlxSprite().loadGraphic(Paths.image('ving'));
		ving.updateHitbox();
		ving.screenCenter();
		add(ving);

        instructionsText = new FlxText(10, 50, FlxG.width - 20, 
            "Press ESC to skip"
        );
		instructionsText.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, "bottom");
		add(instructionsText);

        instructionsText2 = new FlxText(10, 100, FlxG.width - 20, 
            "Press 'G' to access GB Page."
        );
		instructionsText2.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, "bottom");
		add(instructionsText2);

        var duration:Float = (creditsText.height + FlxG.height) / scrollSpeed;
        FlxTween.tween(creditsText, { y: -creditsText.height }, duration, {
            type: FlxTween.ONESHOT,
            onComplete: function(tween:FlxTween) {
    
                MusicBeatState.switchState(new MainMenuState());
            }
        });
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

		checker.x += .5*(elapsed/(1/120)); 
		checker.y -= 0.16;

        if (FlxG.keys.justPressed.ESCAPE) {
            MusicBeatState.switchState(new MainMenuState());
        }

        if (FlxG.keys.justPressed.G) {
            CoolUtil.browserLoad(File.getContent('assets/link/link.txt'));
        }
    }
}
