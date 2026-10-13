package main.java.td4;

import main.Automata;

public class StopState implements State {

    Automata automata;

    public StopState(Automata automata){
        this.automata = automata;
    }

    @Override

    public void handle(){
        Command cmd = automata.getCommand();

        switch(cmd){
            case PLAY:
                System.out.println("Now playing");
                automata.setCommand(Command.PLAY);
                break;
            case STOP:
                System.out.println("Already stopped");
                break;
            case PAUSE:
                System.out.println("Cannot pause from stop");
                break;
            case FORWARD:
                System.out.println("Now forwarding");
                automata.setCommand(Command.FORWARD);
                break;
            case REWIND:
                System.out.println("Now rewinding");
                automata.setCommand(Command.REWIND);
                break;
            default:
                break;
        }
    }
}
