%VERIFICA SE EXISTE O ELEMENTO
pertence(Elem, [Elem|_]).
pertence(Elem, [_|Cauda]):- pertence(Elem, Cauda).

%POSICAO FIXA DO LADRAO
ladrao(posicao(9,5)).

% ======== FUNCAO EXTRA ========
algemas(posicao(1,1)).

formata_saida([], []).
formata_saida([estado(C,_,_)|R], [C| Formatados]):- formata_saida(R, Formatados).

%MONTANDO AS FOLHAS DO GRAFO (HORIZONTAL)
caminho(posicao(1,1),posicao(2,1)).
caminho(posicao(2,1),posicao(3,1)).
caminho(posicao(3,1),posicao(4,1)).
caminho(posicao(4,1),posicao(5,1)).
caminho(posicao(5,1),posicao(6,1)).
caminho(posicao(6,1),posicao(7,1)).
caminho(posicao(7,1),posicao(8,1)).
caminho(posicao(8,1),posicao(9,1)).
caminho(posicao(9,1),posicao(10,1)).
caminho(posicao(1,2),posicao(2,2)).
caminho(posicao(2,2),posicao(3,2)).
caminho(posicao(3,2),posicao(4,2)).
caminho(posicao(4,2),posicao(5,2)).
caminho(posicao(5,2),posicao(6,2)).
caminho(posicao(6,2),posicao(7,2)).
caminho(posicao(7,2),posicao(8,2)).
caminho(posicao(8,2),posicao(9,2)).
caminho(posicao(9,2),posicao(10,2)).
caminho(posicao(1,3),posicao(2,3)).
caminho(posicao(2,3),posicao(3,3)).
caminho(posicao(3,3),posicao(4,3)).
caminho(posicao(4,3),posicao(5,3)).
caminho(posicao(5,3),posicao(6,3)).
caminho(posicao(6,3),posicao(7,3)).
caminho(posicao(7,3),posicao(8,3)).
caminho(posicao(8,3),posicao(9,3)).
caminho(posicao(9,3),posicao(10,3)).
caminho(posicao(1,4),posicao(2,4)).
caminho(posicao(2,4),posicao(3,4)).
caminho(posicao(3,4),posicao(4,4)).
caminho(posicao(4,4),posicao(5,4)).
caminho(posicao(5,4),posicao(6,4)).
caminho(posicao(6,4),posicao(7,4)).
caminho(posicao(7,4),posicao(8,4)).
caminho(posicao(8,4),posicao(9,4)).
caminho(posicao(9,4),posicao(10,4)).
caminho(posicao(1,5),posicao(2,5)).
caminho(posicao(2,5),posicao(3,5)).
caminho(posicao(3,5),posicao(4,5)).
caminho(posicao(4,5),posicao(5,5)).
caminho(posicao(5,5),posicao(6,5)).
caminho(posicao(6,5),posicao(7,5)).
caminho(posicao(7,5),posicao(8,5)).
caminho(posicao(8,5),posicao(9,5)).
caminho(posicao(9,5),posicao(10,5)).


%MONTANDO AS FOLHAS DO GRAFO (VERTICAL)
escada(posicao(1,2),posicao(1,3)).
escada(posicao(4,1),posicao(4,2)).
escada(posicao(5,4),posicao(5,5)).
escada(posicao(10,3),posicao(10,4)).

existe_subida_escada(X, Y):- escada(posicao(X,Y),_).

carrinho(posicao(2,1)).
carrinho(posicao(2,5)).
carrinho(posicao(3,4)).
carrinho(posicao(6,1)).
carrinho(posicao(7,4)).
carrinho(posicao(8,2)).
carrinho(posicao(10,1)).


%VERIFICO SE AS FOLHAS ESTÃO CONECTADAS (CAMINHO HORIZONTAL)
existe_caminho(X,Y,X2,Y2):- caminho(posicao(X,Y), posicao(X2,Y2)).
existe_caminho(X,Y,X2,Y2):- caminho(posicao(X2,Y2), posicao(X,Y)).
%VERIFICO SE AS FOLHAS ESTÃO CONECTADAS (CAMINHO VERTICAL)
existe_caminho(X,Y,X2,Y2):- escada(posicao(X,Y), posicao(X2,Y2)).
existe_caminho(X,Y,X2,Y2):- escada(posicao(X2,Y2), posicao(X,Y)).


%ACOES POSSÍVEIS DO POLICIAL

% ======== FUNCAO EXTRA ========
acao(pegar_algema, estado(posicao(X,Y), sem_algemas, SENTIDO), estado(posicao(X,Y), com_algemas, SENTIDO)):- algemas(posicao(X,Y)).


acao(subir, estado(posicao(X, Y), ALGEMAS, SENTIDO), estado(posicao(X, Y2), ALGEMAS, SENTIDO)):- Y2 is Y+1, existe_caminho(X, Y, X, Y2).


acao(virar_dir, estado(posicao(X, Y), ALGEMAS,esquerda), estado(posicao(X, Y), ALGEMAS,direita)).
acao(andar, estado(posicao(X, Y), ALGEMAS,direita), estado(posicao(X2, Y),  ALGEMAS,direita)):- X2 is X + 1, existe_caminho(X, Y, X2, Y), not(carrinho(posicao(X2, Y))).


acao(pular, estado(posicao(X, Y), ALGEMAS,direita), estado(posicao(X2, Y),  ALGEMAS,direita)):- X1 is X + 1, X2 is X1 + 1, %incremendo das variaveis
carrinho(posicao(X1,Y)),  %verifico se existe carrinho no meio
not(carrinho(posicao(X2,Y))), %se o espaco para onde o policial irá possui não tem carrinho
existe_caminho(X, Y, X1, Y),  %se existe o caminho de transicao
existe_caminho(X1, Y, X2, Y), %se existe o caminho para o novo local
not(existe_subida_escada(X2, Y)), %se o novo local não tem uma escada para atrapalhar
not(ladrao(posicao(X2,Y))). %se o novo local não tiver o ladrão escondido


acao(descer, estado(posicao(X, Y), ALGEMAS, SENTIDO), estado(posicao(X, Y2), ALGEMAS,SENTIDO)):- Y2 is Y-1, existe_caminho(X, Y, X, Y2).


acao(virar_esq, estado(posicao(X, Y), ALGEMAS,direita), estado(posicao(X, Y), ALGEMAS,esquerda)).
acao(andar, estado(posicao(X, Y), ALGEMAS,esquerda), estado(posicao(X2, Y),  ALGEMAS,direita)):- X2 is X-1, existe_caminho(X, Y, X2, Y), not(carrinho(posicao(X2, Y))).


acao(pular, estado(posicao(X, Y), ALGEMAS,esquerda), estado(posicao(X2, Y), ALGEMAS,esquerda)):- X1 is X - 1, X2 is X1 - 1, %incremendo das variaveis
carrinho(posicao(X1,Y)),  %verifico se existe carrinho no meio
not(carrinho(posicao(X2,Y))), %se o espaco para onde o policial irá possui não tem carrinho
existe_caminho(X, Y, X1, Y),  %se existe o caminho de transicao
existe_caminho(X1, Y, X2, Y), %se existe o caminho para o novo local
not(existe_subida_escada(X2, Y)), %se o novo local não tem uma escada para atrapalhar
not(ladrao(posicao(X2,Y))). %se o novo local não tiver o ladrão escondido


%OBTENHO A POSICAO DO LADRAO, E VERIFICO SE ESTÁ NO LOCAL CORRETO, INDEPENDENTE DO SENTIDO DO POLICIAL
meta(estado(A, com_algemas,_)):- ladrao(A).


%solucao por busca em profundidade (bp)
solucao_bp(X, Y, Sentido, Solucao) :- bp([], estado(posicao(X, Y), sem_algemas, Sentido), Solucao).

%Se o primeiro estado da lista é meta, retorna a meta
bp(Caminho, Estado, [Estado|Caminho]) :- meta(Estado).
%se falhar, coloca o no caminho e continua a busca
bp(Caminho, Estado, Solucao) :- acao(ACAO, Estado, Prox_Estado), not(pertence(Prox_Estado,[Estado|Caminho])), bp([Estado|Caminho],Prox_Estado,Solucao),write(' <- '),write(ACAO).


%PROCURA OS CAMINHOS PARA PRENDER O LADRÃO
procura_ladrao(X,Y, Solucao):- solucao_bp(X, Y, direita, Solucao).
procura_ladrao_formatado(X,Y, Caminho):- solucao_bp(X, Y, direita, Solucao), formata_saida(Solucao, Caminho).


%procura_ladrao(5,1,X).