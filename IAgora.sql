CREATE TABLE `users` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `email` varchar(255) UNIQUE NOT NULL,
  `senha` varchar(255) NOT NULL,
  `tipo` int NOT NULL
);

CREATE TABLE `perfil` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int UNIQUE NOT NULL,
  `endereco_id` int,
  `nome` varchar(150) NOT NULL,
  `foto` varchar(500),
  `tipo` int NOT NULL
);

CREATE TABLE `casa` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `grupo_id` int NOT NULL,
  `nome` varchar(150) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `endereco_id` int
);

CREATE TABLE `endereco` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `estado` varchar(100) NOT NULL,
  `rua` varchar(255) NOT NULL,
  `bairro` varchar(150) NOT NULL,
  `pais` varchar(100) NOT NULL DEFAULT 'Brasil',
  `cep` varchar(9) NOT NULL,
  `cidade` varchar(150) NOT NULL,
  `numero` varchar(20),
  `complemento` varchar(150)
);

CREATE TABLE `comodo` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `casa_id` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `descricao` text
);

CREATE TABLE `produto` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `marca` varchar(100),
  `tamanho` decimal(10,2),
  `unidade` varchar(20),
  `imagem` varchar(500)
);

CREATE TABLE `estoque_item` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `casa_id` int NOT NULL,
  `produto_id` int NOT NULL,
  `quantidade` decimal(10,2) NOT NULL DEFAULT 0
);

CREATE TABLE `compra_item` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `compras_id` int NOT NULL,
  `produto_id` int,
  `nome_item` varchar(150),
  `quantidade` int NOT NULL DEFAULT 1,
  `comprado` boolean NOT NULL DEFAULT false,
  `valor` decimal(10,2)
);

CREATE TABLE `receita_item` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `receita_id` int NOT NULL,
  `produto_id` int,
  `nome_item` varchar(150),
  `quantidade` decimal(10,2) NOT NULL
);

CREATE TABLE `limpezas` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `comodo_id` int NOT NULL,
  `nome` varchar(150) NOT NULL,
  `descricao` text,
  `ultima_vez` date,
  `proxima_vez` date
);

CREATE TABLE `execucao_limpeza` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `limpeza_id` int NOT NULL,
  `perfil_id` int NOT NULL,
  `realizada_em` datetime NOT NULL
);

CREATE TABLE `receitas` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `publica` boolean NOT NULL DEFAULT true,
  `nome` varchar(150) NOT NULL,
  `descricao` text,
  `tipo` varchar(50),
  `preparo` text NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'rascunho'
);

CREATE TABLE `receita_favorita` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `receita_id` int NOT NULL
);

CREATE TABLE `compras` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `casa_id` int NOT NULL,
  `nome` varchar(150) NOT NULL,
  `criacao` date NOT NULL
);

CREATE TABLE `categoria_tarefa` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `grupo_id` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cor` varchar(20),
  `icone` varchar(100)
);

CREATE TABLE `tarefa` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `categoria_id` int NOT NULL,
  `nome` varchar(150) NOT NULL,
  `descricao` text,
  `prazo` datetime
);

CREATE TABLE `recorrencia_tarefa` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `tarefa_id` int UNIQUE NOT NULL,
  `frequencia` varchar(30) NOT NULL,
  `intervalo` int NOT NULL DEFAULT 1,
  `dias_semana` json,
  `dia_mes` json,
  `inicio` date NOT NULL,
  `fim` date
);

CREATE TABLE `categoria_financas` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `grupo_id` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cor` varchar(20),
  `icone` varchar(100)
);

CREATE TABLE `recorrencia_financeira` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `grupo_id` int NOT NULL,
  `descricao` text NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `valor_previsto` decimal(15,2) NOT NULL,
  `frequencia` varchar(30) NOT NULL,
  `inicio_em` date NOT NULL,
  `fim_em` date,
  `ativa` boolean NOT NULL DEFAULT true
);

CREATE TABLE `transacao_financeira` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `grupo_id` int NOT NULL,
  `categoria_id` int NOT NULL,
  `conta_id` int,
  `recorrencia_id` int,
  `descricao` text NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `valor` decimal(15,2) NOT NULL,
  `competencia` date NOT NULL,
  `vencimento` date,
  `pago_em` date,
  `status` varchar(30) NOT NULL DEFAULT 'pendente'
);

CREATE TABLE `orcamento` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `grupo_id` int NOT NULL,
  `categoria_id` int NOT NULL,
  `mes` date NOT NULL,
  `limite` decimal(15,2) NOT NULL
);

CREATE TABLE `meta_financeira` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `grupo_id` int NOT NULL,
  `nome` varchar(150) NOT NULL,
  `valor_atual` decimal(15,2) NOT NULL DEFAULT 0,
  `valor_alvo` decimal(15,2) NOT NULL,
  `prazo` date,
  `status` varchar(30) NOT NULL DEFAULT 'ativa'
);

CREATE TABLE `execucao_tarefa` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `tarefa_id` int NOT NULL,
  `data_prevista` datetime NOT NULL,
  `concluida_em` datetime,
  `status` varchar(30) NOT NULL DEFAULT 'pendente'
);

CREATE TABLE `conta_financeira` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `grupo_id` int NOT NULL,
  `nome` varchar(150) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `saldo_inicial` decimal(15,2) NOT NULL DEFAULT 0
);

CREATE TABLE `grupo` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `descricao` text,
  `tipo` varchar(50) NOT NULL
);

CREATE TABLE `grupo_usuario` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `grupo_id` int NOT NULL,
  `user_id` int NOT NULL,
  `apelido` varchar(30),
  `papel` varchar(30) NOT NULL DEFAULT 'membro'
);

CREATE TABLE `jornada` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `nome` varchar(150) NOT NULL,
  `descricao` text,
  `status` varchar(30) NOT NULL DEFAULT 'em_andamento',
  `criada_em` datetime NOT NULL
);

CREATE TABLE `etapa_jornada` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `jornada_id` int NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descricao` text,
  `categoria` varchar(50),
  `ordem` int NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'pendente',
  `prazo` date,
  `concluida_em` datetime
);

CREATE TABLE `tarefa_jornada` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `etapa_id` int NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descricao` text,
  `concluida` boolean NOT NULL DEFAULT false,
  `ordem` int NOT NULL
);

CREATE TABLE `plano_moradia` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `nome` varchar(150) NOT NULL,
  `renda_mensal` decimal(12,2) NOT NULL DEFAULT 0,
  `reserva_atual` decimal(12,2) NOT NULL DEFAULT 0,
  `mudanca_prevista` date,
  `status` varchar(30) NOT NULL DEFAULT 'ativo'
);

CREATE TABLE `custo_moradia` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `plano_id` int NOT NULL,
  `nome` varchar(150) NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `valor` decimal(12,2) NOT NULL DEFAULT 0
);

CREATE TABLE `simulacao_moradia` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `plano_id` int NOT NULL,
  `nome` varchar(150) NOT NULL,
  `renda_mensal` decimal(12,2) NOT NULL,
  `reserva` decimal(12,2) NOT NULL DEFAULT 0,
  `criada_em` datetime NOT NULL
);

CREATE TABLE `simulacao_item` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `simulacao_id` int NOT NULL,
  `nome` varchar(150) NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `valor` decimal(12,2) NOT NULL
);

CREATE TABLE `casa_desejada` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `endereco_id` int,
  `titulo` varchar(150) NOT NULL,
  `descricao` varchar(500),
  `tipo` varchar(150) NOT NULL,
  `valor` decimal(12,2)
);

CREATE TABLE `aula` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `descricao` text,
  `conteudo` text,
  `video_url` varchar(500),
  `imagem` varchar(500),
  `categoria` varchar(100) NOT NULL
);

CREATE TABLE `quiz` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `aula_id` int NOT NULL,
  `titulo` varchar(150) NOT NULL
);

CREATE TABLE `questao` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `quiz_id` int NOT NULL,
  `enunciado` text NOT NULL
);

CREATE TABLE `alternativa` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `questao_id` int NOT NULL,
  `texto` text NOT NULL,
  `correta` boolean NOT NULL DEFAULT false
);

CREATE TABLE `progresso_aula` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `aula_id` int NOT NULL,
  `concluida` boolean NOT NULL DEFAULT false
);

CREATE TABLE `tentativa_quiz` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `quiz_id` int NOT NULL,
  `pontuacao` decimal(5,2)
);

CREATE TABLE `resposta_quiz` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `tentativa_id` int NOT NULL,
  `questao_id` int NOT NULL,
  `alternativa_id` int NOT NULL
);

CREATE TABLE `perfil_empresa` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `endereco_id` int,
  `nome` varchar(150) NOT NULL,
  `cnpj` char(14) UNIQUE NOT NULL,
  `descricao` text,
  `categoria` varchar(150) NOT NULL,
  `logo` varchar(500),
  `banner` varchar(500),
  `telefone` varchar(20) NOT NULL,
  `local_atendimento` json,
  `horario_atendimento` json,
  `email_comercial` varchar(255) NOT NULL,
  `site` varchar(500),
  `data_criacao` datetime NOT NULL,
  `validado` boolean NOT NULL DEFAULT false
);

CREATE TABLE `servico` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `empresa_id` int NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descricao` text NOT NULL,
  `fotos` json,
  `categoria` varchar(100) NOT NULL,
  `preco` decimal(10,2),
  `tipo_preco` varchar(30) NOT NULL,
  `ativo` boolean NOT NULL DEFAULT true,
  `disponibilidade` json,
  `validado` boolean NOT NULL DEFAULT false,
  `nota` decimal(3,2),
  `status_publicacao` varchar(30) NOT NULL DEFAULT 'rascunho',
  `publicado_em` datetime,
  `expira_em` datetime
);

CREATE TABLE `servico_contratado` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `servico_id` int NOT NULL,
  `perfil_id` int NOT NULL,
  `endereco_id` int,
  `descricao` text,
  `data_agendamento` datetime,
  `valor` decimal(10,2) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'pendente',
  `data_contratacao` datetime NOT NULL,
  `data_conclusao` datetime
);

CREATE TABLE `avaliacao_servico` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `contratado_id` int UNIQUE NOT NULL,
  `perfil_id` int NOT NULL,
  `nota` int NOT NULL,
  `comentario` text,
  `data_avaliacao` datetime NOT NULL
);

CREATE TABLE `chat_servico` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `perfil_id` int NOT NULL,
  `empresa_id` int NOT NULL,
  `contratado_id` int UNIQUE
);

CREATE TABLE `mensagem` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `chat_id` int NOT NULL,
  `user_id` int NOT NULL,
  `mensagem` text NOT NULL,
  `data` datetime NOT NULL,
  `lida_em` datetime
);

CREATE TABLE `plano_assinatura` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(100) UNIQUE NOT NULL,
  `descricao` text,
  `preco` decimal(10,2) NOT NULL,
  `beneficios` json,
  `ativo` boolean NOT NULL DEFAULT true
);

CREATE TABLE `assinatura` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `plano_id` int NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'pendente',
  `inicio` datetime NOT NULL,
  `proxima_cobranca` datetime,
  `cancelada_em` datetime
);

CREATE TABLE `metodo_pagamento` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `apelido` varchar(100),
  `bandeira` varchar(30),
  `ultimos_digitos` char(4),
  `token_gateway` varchar(255) UNIQUE NOT NULL,
  `validade_mes` int,
  `validade_ano` int,
  `principal` boolean NOT NULL DEFAULT false,
  `ativo` boolean NOT NULL DEFAULT true
);

CREATE TABLE `pagamento` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `metodo_id` int,
  `assinatura_id` int,
  `publicacao_id` int,
  `valor` decimal(10,2) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'pendente',
  `gateway` varchar(50),
  `transacao_externa_id` varchar(255) UNIQUE,
  `criado_em` datetime NOT NULL,
  `pago_em` datetime
);

CREATE TABLE `publicacao_servico` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `servico_id` int NOT NULL,
  `plano_id` int NOT NULL,
  `inicio` datetime,
  `fim` datetime,
  `valor` decimal(10,2) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'pendente'
);

CREATE TABLE `plano_publicacao` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(100) UNIQUE NOT NULL,
  `descricao` text,
  `preco` decimal(10,2) NOT NULL,
  `duracao_dias` int NOT NULL,
  `ativo` boolean NOT NULL DEFAULT true
);

CREATE UNIQUE INDEX `estoque_item_index_0` ON `estoque_item` (`casa_id`, `produto_id`);

CREATE UNIQUE INDEX `receita_favorita_index_1` ON `receita_favorita` (`user_id`, `receita_id`);

CREATE UNIQUE INDEX `orcamento_index_2` ON `orcamento` (`grupo_id`, `categoria_id`, `mes`);

CREATE UNIQUE INDEX `grupo_usuario_index_3` ON `grupo_usuario` (`grupo_id`, `user_id`);

CREATE UNIQUE INDEX `progresso_aula_index_4` ON `progresso_aula` (`user_id`, `aula_id`);

CREATE UNIQUE INDEX `resposta_quiz_index_5` ON `resposta_quiz` (`tentativa_id`, `questao_id`);

ALTER TABLE `estoque_item` ADD FOREIGN KEY (`casa_id`) REFERENCES `casa` (`id`);

ALTER TABLE `compras` ADD FOREIGN KEY (`casa_id`) REFERENCES `casa` (`id`);

ALTER TABLE `receitas` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `categoria_tarefa` ADD FOREIGN KEY (`grupo_id`) REFERENCES `grupo` (`id`);

ALTER TABLE `categoria_financas` ADD FOREIGN KEY (`grupo_id`) REFERENCES `grupo` (`id`);

ALTER TABLE `recorrencia_financeira` ADD FOREIGN KEY (`grupo_id`) REFERENCES `grupo` (`id`);

ALTER TABLE `transacao_financeira` ADD FOREIGN KEY (`grupo_id`) REFERENCES `grupo` (`id`);

ALTER TABLE `orcamento` ADD FOREIGN KEY (`grupo_id`) REFERENCES `grupo` (`id`);

ALTER TABLE `meta_financeira` ADD FOREIGN KEY (`grupo_id`) REFERENCES `grupo` (`id`);

ALTER TABLE `conta_financeira` ADD FOREIGN KEY (`grupo_id`) REFERENCES `grupo` (`id`);

ALTER TABLE `progresso_aula` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `tentativa_quiz` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `perfil` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `perfil` ADD FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`);

ALTER TABLE `casa` ADD FOREIGN KEY (`grupo_id`) REFERENCES `grupo` (`id`);

ALTER TABLE `casa` ADD FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`);

ALTER TABLE `comodo` ADD FOREIGN KEY (`casa_id`) REFERENCES `casa` (`id`);

ALTER TABLE `estoque_item` ADD FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`);

ALTER TABLE `limpezas` ADD FOREIGN KEY (`comodo_id`) REFERENCES `comodo` (`id`);

ALTER TABLE `execucao_limpeza` ADD FOREIGN KEY (`limpeza_id`) REFERENCES `limpezas` (`id`);

ALTER TABLE `execucao_limpeza` ADD FOREIGN KEY (`perfil_id`) REFERENCES `perfil` (`id`);

ALTER TABLE `receita_item` ADD FOREIGN KEY (`receita_id`) REFERENCES `receitas` (`id`);

ALTER TABLE `receita_item` ADD FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`);

ALTER TABLE `receita_favorita` ADD FOREIGN KEY (`receita_id`) REFERENCES `receitas` (`id`);

ALTER TABLE `receita_favorita` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `compra_item` ADD FOREIGN KEY (`compras_id`) REFERENCES `compras` (`id`);

ALTER TABLE `compra_item` ADD FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`);

ALTER TABLE `tarefa` ADD FOREIGN KEY (`categoria_id`) REFERENCES `categoria_tarefa` (`id`);

ALTER TABLE `recorrencia_tarefa` ADD FOREIGN KEY (`tarefa_id`) REFERENCES `tarefa` (`id`);

ALTER TABLE `execucao_tarefa` ADD FOREIGN KEY (`tarefa_id`) REFERENCES `tarefa` (`id`);

ALTER TABLE `transacao_financeira` ADD FOREIGN KEY (`categoria_id`) REFERENCES `categoria_financas` (`id`);

ALTER TABLE `transacao_financeira` ADD FOREIGN KEY (`recorrencia_id`) REFERENCES `recorrencia_financeira` (`id`);

ALTER TABLE `orcamento` ADD FOREIGN KEY (`categoria_id`) REFERENCES `categoria_financas` (`id`);

ALTER TABLE `transacao_financeira` ADD FOREIGN KEY (`conta_id`) REFERENCES `conta_financeira` (`id`);

ALTER TABLE `grupo_usuario` ADD FOREIGN KEY (`grupo_id`) REFERENCES `grupo` (`id`);

ALTER TABLE `grupo_usuario` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `jornada` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `etapa_jornada` ADD FOREIGN KEY (`jornada_id`) REFERENCES `jornada` (`id`);

ALTER TABLE `tarefa_jornada` ADD FOREIGN KEY (`etapa_id`) REFERENCES `etapa_jornada` (`id`);

ALTER TABLE `plano_moradia` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `custo_moradia` ADD FOREIGN KEY (`plano_id`) REFERENCES `plano_moradia` (`id`);

ALTER TABLE `simulacao_moradia` ADD FOREIGN KEY (`plano_id`) REFERENCES `plano_moradia` (`id`);

ALTER TABLE `simulacao_item` ADD FOREIGN KEY (`simulacao_id`) REFERENCES `simulacao_moradia` (`id`);

ALTER TABLE `casa_desejada` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `casa_desejada` ADD FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`);

ALTER TABLE `quiz` ADD FOREIGN KEY (`aula_id`) REFERENCES `aula` (`id`);

ALTER TABLE `questao` ADD FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`id`);

ALTER TABLE `alternativa` ADD FOREIGN KEY (`questao_id`) REFERENCES `questao` (`id`);

ALTER TABLE `progresso_aula` ADD FOREIGN KEY (`aula_id`) REFERENCES `aula` (`id`);

ALTER TABLE `tentativa_quiz` ADD FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`id`);

ALTER TABLE `resposta_quiz` ADD FOREIGN KEY (`tentativa_id`) REFERENCES `tentativa_quiz` (`id`);

ALTER TABLE `resposta_quiz` ADD FOREIGN KEY (`questao_id`) REFERENCES `questao` (`id`);

ALTER TABLE `resposta_quiz` ADD FOREIGN KEY (`alternativa_id`) REFERENCES `alternativa` (`id`);

ALTER TABLE `perfil_empresa` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `perfil_empresa` ADD FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`);

ALTER TABLE `servico` ADD FOREIGN KEY (`empresa_id`) REFERENCES `perfil_empresa` (`id`);

ALTER TABLE `servico_contratado` ADD FOREIGN KEY (`servico_id`) REFERENCES `servico` (`id`);

ALTER TABLE `servico_contratado` ADD FOREIGN KEY (`perfil_id`) REFERENCES `perfil` (`id`);

ALTER TABLE `servico_contratado` ADD FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`);

ALTER TABLE `avaliacao_servico` ADD FOREIGN KEY (`contratado_id`) REFERENCES `servico_contratado` (`id`);

ALTER TABLE `avaliacao_servico` ADD FOREIGN KEY (`perfil_id`) REFERENCES `perfil` (`id`);

ALTER TABLE `chat_servico` ADD FOREIGN KEY (`contratado_id`) REFERENCES `servico_contratado` (`id`);

ALTER TABLE `chat_servico` ADD FOREIGN KEY (`empresa_id`) REFERENCES `perfil_empresa` (`id`);

ALTER TABLE `chat_servico` ADD FOREIGN KEY (`perfil_id`) REFERENCES `perfil` (`id`);

ALTER TABLE `mensagem` ADD FOREIGN KEY (`chat_id`) REFERENCES `chat_servico` (`id`);

ALTER TABLE `mensagem` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `assinatura` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `assinatura` ADD FOREIGN KEY (`plano_id`) REFERENCES `plano_assinatura` (`id`);

ALTER TABLE `metodo_pagamento` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `pagamento` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `pagamento` ADD FOREIGN KEY (`metodo_id`) REFERENCES `metodo_pagamento` (`id`);

ALTER TABLE `pagamento` ADD FOREIGN KEY (`assinatura_id`) REFERENCES `assinatura` (`id`);

ALTER TABLE `pagamento` ADD FOREIGN KEY (`publicacao_id`) REFERENCES `publicacao_servico` (`id`);

ALTER TABLE `publicacao_servico` ADD FOREIGN KEY (`plano_id`) REFERENCES `plano_publicacao` (`id`);

ALTER TABLE `publicacao_servico` ADD FOREIGN KEY (`servico_id`) REFERENCES `servico` (`id`);
