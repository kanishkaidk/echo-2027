import 'models.dart';

/// Sample narrative content: A 3-node starter branch
/// Intro → Dilemma → Immediate Outcome

final Map<String, StoryNode> storyData = {
  'intro': StoryNode(
    id: 'intro',
    title: 'The Wake',
    text: '''
# The Wake

The morning drone alarm cuts through your hab-unit at 0600. Another gray dawn in New Seattle, 2076.

Outside your window, the sky churns with that familiar burnt-orange haze. The mega-city sprawls beneath you like a circuit board—endless towers, endless consumption. But lately, whispers have grown louder in the underground channels.

A message appeared on your secure feed: *"We need people like you. Meet at the Arbor tonight. Midnight. Come alone."*

You've heard rumors of a resistance movement—people trying to push back against the endless extraction, the toxins, the accelerating collapse. Your community trust is still fresh, your reputation unspotted. They're looking for operatives.

But getting involved could cost you everything.
    ''',
    backgroundImageUrl: 'assets/bg_intro.jpg',
    choices: [
      Choice(
        text: 'Go to the meeting. Learn what they want.',
        nextNodeId: 'dilemma',
        modifiers: StateModifiers(
          trustDelta: 5,
          ecoDelta: 0,
          fundsDelta: 0,
        ),
        isHighStakes: false,
      ),
      Choice(
        text: 'Ignore the message. It\'s too risky.',
        nextNodeId: 'outcome_cautious',
        modifiers: StateModifiers(
          trustDelta: -10,
          ecoDelta: -5,
          fundsDelta: 0,
        ),
        isHighStakes: false,
      ),
    ],
  ),
  'dilemma': StoryNode(
    id: 'dilemma',
    title: 'The Arbor',
    text: '''
# The Arbor

The building is condemned—a relic of the 2040s when vertical gardens were a trend before the water wars. Vines consume the walls. Bioluminescent moss marks your path.

Three figures wait in the shadows of what was once a greenhouse. The one in front wears a necklace of seed pods.

"You came," she says. Her eyes are sharp, calculating. "We're called the **Echoes**. We document the damage—then we fix it. But we need resources, safe houses, and people willing to move quickly."

She slides a data-chip across the table. On it: coordinates for a polluted aquifer they've been monitoring. The remediation kit costs 300 credits—resources you have, but barely.

"We can show you impact," she continues. "But we need commitment. Full commitment. This is the choice that defines everything after."

Behind her, you notice surveillance cameras—their lenses have been painted over. Expertly. This group has done this before.
    ''',
    backgroundImageUrl: 'assets/bg_dilemma.jpg',
    choices: [
      Choice(
        text: 'Fund their aquifer remediation. This is what change looks like.',
        nextNodeId: 'outcome_committed',
        modifiers: StateModifiers(
          trustDelta: 25,
          ecoDelta: 20,
          fundsDelta: -300,
        ),
        isHighStakes: true,
      ),
      Choice(
        text: 'Ask for smaller commitments first. Test the waters.',
        nextNodeId: 'outcome_pragmatic',
        modifiers: StateModifiers(
          trustDelta: 8,
          ecoDelta: 10,
          fundsDelta: -50,
        ),
        isHighStakes: false,
      ),
      Choice(
        text: 'It\'s a trap. Report them to Enforcement.',
        nextNodeId: 'outcome_betrayal',
        modifiers: StateModifiers(
          trustDelta: -50,
          ecoDelta: -30,
          fundsDelta: 500,
        ),
        isHighStakes: true,
      ),
    ],
  ),
  'outcome_committed': StoryNode(
    id: 'outcome_committed',
    title: 'Signal Sent',
    text: '''
# Signal Sent

The credits leave your account. The woman nods—a gesture that feels both gratitude and gravity.

"Welcome to the Echoes," she says. "You've just become a fugitive."

Over the next 72 hours, you help deploy the remediation kit. The aquifer's pH stabilizes. Microbes begin to cycle nutrients again. It's not much—a drop in an ocean of poison—but it's *real*.

News hits the feeds: *"Unauthorized Environmental Intervention. Authorities Investigating."* They don't have your name. Not yet. But they will.

You've bought yourself a seat at the resistance's table. And painted a target on your back.

**END OF CHAPTER ONE**
    ''',
    backgroundImageUrl: 'assets/bg_outcome_committed.jpg',
    choices: [],
    isFinal: true,
  ),
  'outcome_pragmatic': StoryNode(
    id: 'outcome_pragmatic',
    title: 'A Measured Step',
    text: '''
# A Measured Step

"Smart," the woman says, almost smiling. "We respect caution."

You fund a smaller project—distributing air filters in the Lower Sprawl. It's humanitarian, not radical. No laws broken. The Echoes watch you work, measuring your reliability.

Over weeks, trust builds. You're invited to briefings. You learn their network runs deeper than you imagined—policy makers, engineers, even someone inside the Enforcement Bureau.

But something nags at you: without bigger moves, the collapse will outpace the cure. Real change demands real sacrifice.

For now, you've kept your life. You've also kept your distance from the fire.

**END OF CHAPTER ONE**
    ''',
    backgroundImageUrl: 'assets/bg_outcome_pragmatic.jpg',
    choices: [],
    isFinal: true,
  ),
  'outcome_cautious': StoryNode(
    id: 'outcome_cautious',
    title: 'The Price of Fear',
    text: '''
# The Price of Fear

You delete the message. You don't go to the Arbor.

The next morning, the feeds report a raid: three arrests, one dead. The resistance cell at the Arbor is dismantled. The woman with the seed-pod necklace is in custody.

You don't know if they gave up names. You don't know if your silence saved you or damned you.

Weeks pass. The orange sky doesn't change. The aquifer continues to poison. You keep your credits, your reputation, your quiet guilt.

Sometimes the hardest weight to carry is the one you choose not to shoulder.

**END OF CHAPTER ONE**
    ''',
    backgroundImageUrl: 'assets/bg_outcome_cautious.jpg',
    choices: [],
    isFinal: true,
  ),
  'outcome_betrayal': StoryNode(
    id: 'outcome_betrayal',
    title: 'The New Order',
    text: '''
# The New Order

The Enforcement Bureau rewards your tip generously. 500 credits, plus a commendation in your official record.

The Echoes cell is destroyed. Their equipment seized. The woman and her network vanish into detention centers that don't appear on any map.

But something has changed in the city. Enforcement patrols double. Monitoring increases. The Bureau wants to be seen crushing resistance before it spreads.

And you've become the informant they use as a template—reliable, compensated, expendable when no longer useful.

The aquifer remains polluted. The sky remains orange.

You can cash the credits, but can you spend them without remembering the cost?

**END OF CHAPTER ONE**
    ''',
    backgroundImageUrl: 'assets/bg_outcome_betrayal.jpg',
    choices: [],
    isFinal: true,
  ),
};
