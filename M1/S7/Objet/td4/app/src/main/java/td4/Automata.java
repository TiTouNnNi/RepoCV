package td4;

import java.lang.Thread.State;

import main.java.td4.Command;

public class Automata implements Context {

    private State currentState;
    private Command currentCommand;

    public void loop(){
        currentState.loop();
    }

    public State getCurrentState(){
        return currentState;
    }

    public void setState(State state){
        currentState = state;
    }

    public Command getCommand(){
        return currentCommand;
    }

    public void setCommand(Command command){
        currentCommand = command;
    }

}
