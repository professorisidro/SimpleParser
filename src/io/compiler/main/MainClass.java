package io.compiler.main;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

import io.compiler.core.UFABCGrammarLexer;
import io.compiler.core.UFABCGrammarParser;
import io.compiler.core.ast.Program;

public class MainClass {
	public static void main(String[] args) {
		try {
			UFABCGrammarLexer lexer;
			UFABCGrammarParser parser;
			
			// crio o analisador léxico a partir da leitura de um arquivo
			lexer = new UFABCGrammarLexer(CharStreams.fromFileName("program.in"));
			
			// agora a partir do analisador lexico, obtenho um fluxo de tokens
			CommonTokenStream tokenStream = new CommonTokenStream(lexer);
			
			// crio o parser a partir do tokenStream
			parser = new UFABCGrammarParser(tokenStream);
			
			
			// agora eu quero chamar do meu jeito
			System.out.println("UFABC Compiler");
			parser.programa();
			System.out.println("Compilation Successfully - Good Job");


			/* vou deixar aqui a geracao do codigo do programa*/
			Program program = parser.getProgram();
			
			System.out.println(program.generateTarget());
			try {
				File f = new File(program.getName()+".java");
				FileWriter fr = new FileWriter(f);
				PrintWriter pr = new PrintWriter(fr);
				pr.println(program.generateTarget());
				pr.close();
			}
			catch (IOException ex) {
				ex.printStackTrace();
			}
			
			
		}
		catch(Exception ex) {
			System.err.println("Error: "+ex.getMessage());
			//ex.printStackTrace();
		}
	}
}
