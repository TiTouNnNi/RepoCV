package main.java.td4;

import javax.tools.ForwardingFileObject;

import main.Automata;

public class ForwadingState implements State {

    Automata automata;

    public void ForwardingState(Automata automata){
        this.automata = automata;
    }

    @Override
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
                System.out.println("Cannot forward from forward");
                break;
            case REWIND:
                System.out.println("Cannot rewind from forward");
                break;
            default:
                break;
        }
    }
}
