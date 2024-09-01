# RoboZapGame
 projekt na UEC2
## Wstęp i zasady gry

Nasz projekt to prosta gra napisana w języku SystemVerilog wzorująca się na grze typu "rosyjska ruletka", natomiast zamiast rewolwera na ekranie znajduje się 8 dźwigni, które można przeciągnąć w stronę swoją (ButtonDown), lub przeciwnika (ButtonUp). Zmianę dźwigni dokonuje się za pomocą przycisków ButtonLeft i ButtonRight. Reset synchroniczny działa na przycisku ButtonCenter.

Celem gry jest  wyeliminowanie przeciwnika. Każda dźwignia może zadać obrażenia osobie na którą została przeciągnięta, ale także może nic nie zrobić. W wypadku przeciągnięcia dźwigni na swoją stronę pozyskujemy dodatkową turę, ale wiąże się to z ryzykiem. Pozycje "śmiertelnych" dźwigni są losowane przy każdym rozpoczęciu rozgrywki.

##Testbenche

Przygotowaliśmy do każdego ważniejszego modułu testy, żeby upewnić się, że wszystkie moduły działają poprawnie

## Uruchamianie symulacji

Symulacje uruchamia się skryptem `run_simulation.sh`.

 ```bash
  run_simulation.sh -t top_vga
  run_simulation.sh -gt top_logic
  run_simulation.sh -gt top_fpga
  run_simulation.sh -gt levers_info
  ```

