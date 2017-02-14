package com.sixtyfour.system;

import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.For;
import com.sixtyfour.elements.commands.Gosub;
import com.sixtyfour.elements.commands.On;

/**
 * A StackEntry can either be a reference to a FOR or to a GOSUB/ON...GOSUB
 * command.
 */
public class StackEntry {

	/** The command */
	private Command command;
	private boolean isFor = false;
	private boolean isJump = false;

	/**
	 * Instantiates a new stack entry.
	 * 
	 * @param command
	 *            the command
	 */
	public StackEntry(Command command) {
		this.command = command;
		isFor = command instanceof For;
		isJump = command instanceof Gosub || command instanceof On;
	}

	/**
	 * Returns the command.
	 * 
	 * @return the command
	 */
	public Command getCommand() {
		return command;
	}

	/**
	 * Checks if it an entry for a FOR command.
	 * 
	 * @return true, if it is
	 */
	public boolean isFor() {
		return isFor;
	}

	/**
	 * Checks if it is an entry for a GOSUB or ON...GOSUB command.
	 * 
	 * @return true, if it is
	 */
	public boolean isSubroutineCall() {
		return isJump;
	}
}
