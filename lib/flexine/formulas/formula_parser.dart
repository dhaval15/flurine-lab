import 'package:petitparser/petitparser.dart';
import 'package:flurine_launcher/flexine/formulas/keywords.dart';

/* Rules

 */

class FormulaGrammarDefinition extends GrammarDefinition {
  Parser token(input) {
    if (input is String) {
      input = input.length == 1 ? char(input) : string(input);
    } else if (input is Function) {
      input = ref(input);
    }
    if (input is! Parser || input is TrimmingParser || input is TokenParser) {
      throw ArgumentError('Invalid token parser: $input');
    }
    return input.token().trim(ref(_hiddenStuff()));
  }

  _time() => ref(token, TIME);

  _music() => ref(token, MUSIC);

  _http() => ref(token, HTTP);

  _weather() => ref(token, WEATHER);

  _notification() => ref(token, NOTIFICATION);

  _service() => ref(token, SERVICE);

  _golbal() => ref(token, GLOBAL);

  dynamic runTime;

  @override
  Parser start() => ref(runTime).end();

  _hiddenStuff() => ref(_whitespace);

  _whitespace() => whitespace();
}
