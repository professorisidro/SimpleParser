package io.compiler.types;

public class Var {
	private String id;
	private Types type;
	public Var(String id, Types type) {
		super();
		this.id = id;
		this.type = type;
	}
	public Var(String id) {
		super();
		this.id = id;
	}
	public Var() {
		super();
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Types getType() {
		return type;
	}
	public void setType(Types type) {
		this.type = type;
	}
	@Override
	public String toString() {
		return "Var [id=" + id + ", type=" + type + "]";
	}
	
	

}
