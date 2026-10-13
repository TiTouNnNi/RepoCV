package main.java.td4;

import main.Automata;

public class RewindingState implements State {

    Automata automata;

    public RewindingState(Automata automata){
        this.automata = automata;
    }


    public void handle(){
        Command cmd = automata.getCommand();

        switch(cmd){
            case PLAY:
                System.out.println("Cannot play from forward");
                break;
            case STOP:
                System.out.println("Now stopping");
                automata.setCommand(Command.STOP);
                break;
            case PAUSE:
                System.out.println("Cannot pause from forward");
                break;
            case FORWARD:
                System.out.println("Already forwarding");
                break;
            case REWIND:
                System.out.println("Cannot rewind from forward");
                break;
            default:
                break;
        }
    }
}
