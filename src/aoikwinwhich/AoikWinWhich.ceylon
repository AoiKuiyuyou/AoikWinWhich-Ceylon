//
import ceylon.collection { LinkedList }
import java.io { File }
import java.lang { System }
import java.nio.file { Files, Paths }

shared object aoikWinWhich {
    
    shared {String*} uniq({String*} item_s) {
        value item_s_new = LinkedList<String>();
        
        for (item in item_s) {
            if (!(item in item_s_new)) {
                item_s_new.add(item);
            }
        }
        
        return item_s_new;
    }
    
    shared {String*} find_executable(String prog) {
        // 8f1kRCu
        value env_var_PATHEXT = System.getenv("PATHEXT") else "";
        
        // 6qhHTHF
        // split into a list of extensions
        variable {String*} ext_s = (env_var_PATHEXT == "")
            then {}    
            else env_var_PATHEXT.split((x) => x == (File.pathSeparator[0] else ';'));
        
        // 2pGJrMW
        // strip
        ext_s = ext_s.map((x) => x.trim(' '.equals));

        // 2gqeHHl
        // remove empty
        ext_s = ext_s.filter((x) => x != "");
        
        // 2zdGM8W
        // convert to lowercase
        ext_s = ext_s.map((x) => x.lowercased);
        
        // 2fT8aRB
        // uniquify
        ext_s = uniq(ext_s);
        
        value ext_s2 = LinkedList<String>(ext_s);

        // 4ysaQVN
        value env_var_PATH = System.getenv("PATH") else "";
        
        // 6mPI0lg
        variable LinkedList<String> dir_path_s = (env_var_PATH == "")
            then LinkedList<String>()
            else LinkedList<String>(env_var_PATH.split((x) => x == (File.pathSeparator[0] else ';')));

        // 5rT49zI
        // insert empty dir path to the beginning
        //
        // Empty dir handles the case that |prog| is a path, either relative or
        //  absolute. See code 7rO7NIN.
        dir_path_s.insert(0, "");
        
        // 2klTv20
        // uniquify
        dir_path_s = LinkedList<String>(uniq(dir_path_s));
        
        //
        value prog_lc = prog.lowercased;
        
        value prog_has_ext = ext_s2.any((ext) => prog_lc.endsWith(ext));
        
        // 6bFwhbv
        value exe_path_s = LinkedList<String>();
        
        for (dir_path in dir_path_s) {
            // 7rO7NIN
            // synthesize a path with the dir and prog
            value path = (dir_path == "")
                then prog
                else Paths.get(dir_path, prog).string;
            
            // 6kZa5cq
            // assume the path has extension, check if it is an executable
            if (prog_has_ext && Files.isRegularFile(Paths.get(path))) {
                 exe_path_s.add(path);
            }
            
            // 2sJhhEV
            // assume the path has no extension
            for (ext in ext_s) {
                // 6k9X6GP
                // synthesize a new path with the path and the executable extension
                value path_plus_ext = path + ext;

                // 6kabzQg
                // check if it is an executable
                if (Files.isRegularFile(Paths.get(path_plus_ext))) {
                    exe_path_s.add(path_plus_ext);
                }
            }
        }
        
        // 8swW6Av
        // uniquify
        value exe_path_s2 = uniq(exe_path_s);
        
        //
        return exe_path_s2;
    }
    
    shared void main() {
        // 9mlJlKg
        // check if one cmd arg is given
        if (process.arguments.size != 1) {
            // 7rOUXFo
            // print program usage
            print("Usage: aoikwinwhich PROG");
            print("");
            print("#/ PROG can be either name or path");
            print("aoikwinwhich notepad.exe");
            print("aoikwinwhich C:\\Windows\\notepad.exe");
            print("");
            print("#/ PROG can be either absolute or relative");
            print("aoikwinwhich C:\\Windows\\notepad.exe");
            print("aoikwinwhich Windows\\notepad.exe");
            print("");
            print("#/ PROG can be either with or without extension");
            print("aoikwinwhich notepad.exe");
            print("aoikwinwhich notepad");
            print("aoikwinwhich C:\\Windows\\notepad.exe");
            print("aoikwinwhich C:\\Windows\\notepad");

            // 3nqHnP7
            return;
        }
        
        // 9m5B08H
        // get name or path of a program from cmd arg
        value prog = process.arguments[0] else "";
        
        // 8ulvPXM
        // find executables
        value path_s = find_executable(prog);

        // 5fWrcaF
        // has found none, exit
        if (path_s.size == 0) {
            // 3uswpx0
            return;
        }
        
        // 9xPCWuS
        // has found some, output
        value txt = "\n".join(path_s);
        
        print(txt);
        
        // 4s1yY1b
        return;
    }
}

// define a toplevel method |aoikwinwhich::main|
shared void main() {
    aoikWinWhich.main();
}
