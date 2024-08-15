# Tic Tac Toe App - Mobile Case Study for Chant Social Inc.


## Case Detail

- Anonymous Users:
  - Users must enter a name to view the game list.
- Create Game:
  - Set game name and background color
  - Choose two participants
- Real-Time List:
  - Games are updated instantly via Firebase/Supabase.
- Game Screen:
  - Play on a 3x3 grid with "X" and "O"
  - Game background color is as set during creation
- Game End:
  - If a winner is determined, the game is marked as complete
  - If it’s a draw, the game restarts automatically
- Bonus:
  - Option to select different grid sizes on the create game screen

## Features

- Add username
- Game Lists
- Add Game
- Change Game Board
- Wait for Other User
- Join Game



## Screens


https://github.com/user-attachments/assets/b190cb63-b999-419c-9081-ded36d28efee



## Installation


### Steps

1. Clone this repository:

    ```bash
    git clone https://github.com/your-username/tic-tac-toe-case.git
    ```

2. Navigate to the project directory:

    ```bash
    cd tic-tac-toe-case
    ```

3. Install the necessary packages:

    ```bash
    flutter pub get
    ```

4. Run the application:

    ```bash
    flutter run
    ```

## Usage

When you open the app, you’ll see the name entry screen if you haven’t set a name before. Enter your name to proceed. On the main screen, you can:

- Create a Game: Tap the `+` button, set the game name, choose a background color, and select two participants.
- View Games: The game list screen shows all available games. Refreshes automatically with any changes.
- Play a Game: Tap on a game to start. Use the 3x3 grid to place "X" or "O". The game background will match the color set during creation.
- Game End: If the game ends with a winner, it’s marked as complete. If it’s a draw, the game restarts automatically.

## Contributing

If you want to contribute, please create a pull request. All contributions are welcome!
