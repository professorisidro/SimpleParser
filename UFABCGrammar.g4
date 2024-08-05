grammar UFABCGrammar;

@header {
	import java.util.ArrayList;
	import io.compiler.types.*;
}

@members {
    private ArrayList<Var> varList = new ArrayList<Var>();
    private ArrayList<Var> currentDecl = new ArrayList<Var>();
    private Types currentType;
    
    public void updateType(){
    	for(Var v: currentDecl){
    	   v.setType(currentType);
    	   varList.add(v);
    	}
    }
    public void exibirVar(){
        for (Var v: varList){
        	System.out.println(v);
        }
    }
}

programa	: 'programa' 
               declaravar+
               expr 
               'fimprog'
			;
			
declaravar	: 'declare' { currentDecl.clear(); } 
               ID  { currentDecl.add(new Var(_input.LT(-1).getText()));}
               ( VIRG ID                
              		 { currentDecl.add(new Var(_input.LT(-1).getText()));}
               )*	 
               DP 
               (
               'number' {currentType = Types.NUMBER;}
               |
               'text' {currentType = Types.TEXT;}
               ) 
               
               { updateType(); } 
               PV
			;		
			
expr		:  termo exprl PV
			;
			
termo		: ID     
			| NUM    
			;
			
exprl		: ( OP termo ) *
			;	
			
OP			: '+' | '-' | '*' | '/' 
			;	
			
ID			: [a-z] ( [a-z] | [A-Z] | [0-9] )*		
			;
			
NUM			: [0-9]+ ('.' [0-9]+ )?
			;			
			
VIRG		: ','
			;
						
PV			: ';'
            ;			
						
DP			: ':'
		    ;
		    			
WS			: (' ' | '\n' | '\r' | '\t' ) -> skip
			;