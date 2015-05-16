{
    Programa: Snake-ZicaDoBaile
    Descrição: Snake procura ponto alimento e a cada ponto alimento comido, corpo da snake cresce 1 e diminui 5 de delay
    Programador: Rafael Reis
    Data: 22/05/2013
    Hora: 23:40
    Bugs Identificados:
        1 => problema com case quando corpo da cobra já grande e fica incisivamente precionando direção contrária.
        2 => problema com case quando muda a direção corpo da cobra perde 1 ponto, sendo assim quando com 5 pontos
            de corpo não é possivel esbarrar no próprio corpo.
                EX.:
                     Cabeça ponto = @
                     proxima direção é para cima, seguindo a lógica o rabo perde 1 ficando um quadrado donde o @
                     cobre um * executando um conflito no corpo da cobra
                         _ _ _ _ _ _         _ _ _ _ _ _ _
                        |            |      |             |
                        |   ***      |      |  *@         |
                        |   *@       |      |  **         |
                        |            |      |             |
                        |_ _ _ _ _ _ |      |_ _ _ _ _ _ _|
}
Program snake;

uses crt;{ to linux}
{uses wincrt;}{ to windows}

    function direction(key:char):integer;
    begin
        case key of

            #72 : direction:=1; //seta pra cima
            #77 : direction:=2;    //seta pra direita
            #80 : direction:=3;    //seta pra baixo
            #75 : direction:=4;    //seta pra esquerda
            //else continue;

        end;
    end;

    procedure mountScreen(b:boolean);
        var
            i,ii : integer;
    begin

        if b = true then
        begin
            for i := 1 to 80 do
            begin
                for ii := 1 to 25 do
                begin
                    gotoxy(i,ii);
                    if ((i=1) or (i=80) or (ii=1) or (ii=21) or (ii=25)) then
                        write('=')
                    else
                        write(' ');
                end;
            end;
            gotoxy(27,23);
            write('APERTE ENTER PARA COMEÇAR!!!');
        end
        else
        begin

            for i := 22 to 24 do
            begin
                for ii := 2 to 79 do
                begin
                    gotoxy(ii,i);
                    write(' ');
                end;
            end;

            gotoxy(35,23);
            write('Você perdeu');
        end;

    end;

    var
        SBx, SBy, SBxbff, SBybff : array[1..1404] of integer;
            x, y,
            cx, cy,
            c, i,
            d,
            time : integer;
        start, stop, finish: boolean;

Begin
    time := 250;
    cx := 12;
    cy := 13;
    x := 40;
    y := 11;
    d := 2;
    c := 1;
    start := false;
    mountScreen(true);

    //Inicio do *
        SBx[1] := 40;
        SBy[1] := 11;

    while 1=1 do
    begin

        if ((start = false) or (stop = true)) then
        begin
            gotoxy(SBx[1],SBy[1]);
            write('*');
            readln;
            start := true;
            stop := false;
            gotoxy(24,22);
            write('APERTE  P  PARA PAUSAR O JOGO');
            gotoxy(24,23);
            write('APERTE  CTRL + C  PARA PARAR O JOGO');
        end;

        if keypressed then
        begin
            case readkey of
                'p' : stop := true;
                'P' : stop := true;
            end;
        end;

        if keypressed then
        begin
            case direction(readkey) of
                1 :     begin
                        if d=3 then
                            continue
                        else
                        begin
                            y := y - 1;
                            d := 1;
                        end;
                     end;
                2 :     begin
                        if d = 4 then
                            continue
                        else
                        begin
                            x := x + 1;
                            d := 2;
                        end;
                     end;
                3 :     begin
                        if d = 1 then
                            continue
                        else
                        begin
                            y := y + 1;
                            d := 3;
                        end;
                    end;
                4 :     begin
                        if d = 2 then
                            continue
                        else
                        begin
                            x := x - 1;
                            d := 4;
                        end;
                     end;
            end;
            //else continue;
        end
        else
        begin
            case d of
                1 : y:=y-1;
                2 : x:=x+1;
                3 : y:=y+1;
                4 : x:=x-1;
            end;
        end;

        if ((x=cx) and (y=cy)) then
        begin
            c := c+1;
            if time <> 0 then
                time := time - 5;
        end;

        if c = 1 then
        begin
            gotoxy(SBx[1],SBy[1]);
            write(' ');
            SBx[1] := x;
            SBy[1] := y;
        end
        else
        begin

            if ((x=cx) and (y=cy)) then
            begin
                cx := SBx[c-1];
                cy := SBy[c-1];
            end
            else
            begin
                gotoxy(SBx[c],SBy[c]);
                write(' ');
                SBx[c] := 0;
                SBy[c] := 0;
            end;

            for i := 1 to c do
            begin
                SBxbff[i] := SBx[i];
                SBybff[i] := SBy[i];
            end;
            for i := 1 to c do
            begin
                SBx[i+1] := SBxbff[i];
                SBy[i+1] := SBybff[i];
                if i = 1 then
                begin
                    SBx[1] := x;
                    SBy[1] := y;
                end;
            end;
        end;

        i := c;
        while i > 0 do
        begin
            gotoxy(SBx[i],SBy[i]);
            write('*');
            i:=i-1;
        end;

        gotoxy(cx,cy);
        write('#');

        delay(time);

          for i := 7 to c do
        begin
            if ((x=SBx[i]) and (y=SBy[i])) then
            begin
                gotoxy(x,y);
                write('X');
                mountScreen(false);
                finish := true;
                break;
            end;
        end;
          if ((x=1)or(x=80)or(y=1)or(y=21)) then
        begin
            gotoxy(x,y);
            write('X');
            mountScreen(false);
            finish := true;
        end;

        if finish = true then
            break;

    end;

    readln;

End.
