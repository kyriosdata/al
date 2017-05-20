/*
 * Copyright (c) 2017
 *
 * Fábio Nogueira de Lucena
 * Fábrica de Software - Instituto de Informática (UFG)
 *
 * Creative Commons Attribution 4.0 International License.
 */

package com.github.kyriosdata.aql;

import org.antlr.v4.runtime.CodePointBuffer;
import org.antlr.v4.runtime.CodePointCharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.junit.jupiter.api.Test;

import java.io.FileNotFoundException;
import java.nio.CharBuffer;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class AqlTest {

    @Test
    public void aprendendo() throws FileNotFoundException {
        CodePointCharStream stream = wrapStringEmStream("hello atencao");

        AqlLexer lexer = new AqlLexer(stream);
        CommonTokenStream cts = new CommonTokenStream(lexer);
        AqlParser parser = new AqlParser(cts);
        ParseTree pt = parser.r();

        assertEquals("(r hello atencao)", pt.toStringTree(parser));
    }

    private CodePointCharStream wrapStringEmStream(String string) {
        CharBuffer cb = CharBuffer.wrap(string.toCharArray());
        CodePointBuffer cpb = CodePointBuffer.withChars(cb);
        return CodePointCharStream.fromBuffer(cpb);
    }
}
