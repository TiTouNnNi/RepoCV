package main.java.td4;

import main.Automata;

public class PauseState implements State {

    Automata automata;

    public PauseState(Automata automata){
        this.automata = automata;
    }

    public void handle(){
        Command cmd = automata.getCommand();

        switch(cmd){
            case PLAY:
                System.out.println("Now playing");
                automata.setCommand(Command.PAUSE);
                break;
            case STOP:
                System.out.println("Cannot stop from pause");
                break;
            case PAUSE:
                System.out.println("Already paused");
                break;
            case FORWARD:
                System.out.println("Cannot forward from pause");
                break;
            case REWIND:
                System.out.println("Cannot rewind from pause");
                break;
            default:
                break;
        }
    }
}
