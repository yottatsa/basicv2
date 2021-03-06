package com.sixtyfour.extensions.textmode.commands;

import java.util.List;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.extensions.graphics.commands.AbstractGraphicsCommand;
import com.sixtyfour.extensions.textmode.ConsoleDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The CONSOLE command
 * 
 * @author EgonOlsen
 * 
 */
public class Console extends AbstractGraphicsCommand {

	public Console() {
		super("CONSOLE");
	}

	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos,
			boolean lastPos, Machine machine) {
		String ret = super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine, 1, 3);
		List<Atom> pars = Parser.getParameters(term);
		checkTypes(pars, linePart, Type.STRING, Type.STRING, Type.STRING, Type.STRING);
		return ret;
	}

	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		List<Atom> pars = Parser.getParameters(term);
		Atom m = pars.get(0);
		ConsoleDevice window = ConsoleDevice.getDevice(machine);
		int mode = VarUtils.getInt(m.eval(machine));
		boolean clear = true;
		int width = 800;
		int height = 500;
		if (window != null && mode == 0) {
			window.dispose();
		} else {
			if (pars.size() > 1) {
				clear = VarUtils.getInt(pars.get(1).eval(machine)) != 0;
			}

			if (pars.size() > 2) {
				width = VarUtils.getInt(pars.get(2).eval(machine));
			}

			if (pars.size() > 3) {
				height = VarUtils.getInt(pars.get(4).eval(machine));
			}

			ConsoleDevice.openDevice(machine, mode, clear, width, height);
		}
		return null;
	}

}
