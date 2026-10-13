package main.java.td4;

import main.Automata;

public class PlayingState implements State {

    Automata automata;

    public PlayingState(Automata automata){
        this.automata = automata;
    }

        public void handle(){
        Command cmd = automata.getCommand();

        switch(cmd){
            case PLAY:
                System.out.println("Already playing");
                break;
            case STOP:
                System.out.println("Now stopping");
                automata.setCommand(Command.STOP);
                break;
            case PAUSE:
                System.out.println("Now pausing");
                automata.setCommand(Command.PAUSE);
                break;
            case FORWARD:
                System.out.println("Cannot forward from play");
                break;
            case REWIND:
                System.out.println("Cannot rewind from play");
                break;
            default:
                break;
        }
    }
}
