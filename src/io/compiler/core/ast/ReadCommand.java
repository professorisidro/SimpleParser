package io.compiler.core.ast;

import io.compiler.types.Types;
import io.compiler.types.Var;

public class ReadCommand extends Command {

	private Var var;

	public ReadCommand() {
		super();
	}

	public ReadCommand(Var var) {
		super();
		this.var = var;
	}

	public Var getVar() {
		return var;
	}

	public void setVar(Var var) {
		this.var = var;
	}

	@Override
	public String generateTarget() {
		// TODO Auto-generated method stub
		return var.getId() + " = " + ((var.getType()==Types.NUMBER)?"_scTrx.nextInt();":"_scTrx.nextLine();")+"\n";
	}

}
