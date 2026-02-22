// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get errUnknown => 'Ocorreu um erro inesperado.';

  @override
  String get errMissingToken => 'Sessão expirada. Inicie sessão novamente.';

  @override
  String get errInvalidToken => 'Sessão inválida. Inicie sessão novamente.';

  @override
  String get errInvalidRequest => 'Pedido inválido.';

  @override
  String get errEmailAlreadyUsed => 'Este e-mail já está em utilização.';

  @override
  String get errUserNotFound => 'Utilizador não encontrado.';

  @override
  String get errInvalidCredentials => 'E-mail ou palavra-passe incorretos.';

  @override
  String get errInvalidCEP => 'Código postal inválido.';

  @override
  String get errCEPNotFound => 'Código postal não encontrado.';

  @override
  String get errExternalServiceFailure =>
      'Serviço externo indisponível. Tente novamente.';

  @override
  String get errInvalidExternalResponse =>
      'Resposta inválida do serviço externo.';

  @override
  String get errExternalBadRequest => 'Pedido rejeitado pelo serviço externo.';

  @override
  String get errInvalidAdType => 'Tipo de anúncio inválido.';

  @override
  String get errInvalidPrice => 'Preço inválido. Deve ser superior a zero.';

  @override
  String get errMissingAddressField =>
      'Preencha todos os campos obrigatórios da morada.';

  @override
  String get errInvalidImageType =>
      'Formato de imagem inválido. Utilize JPG ou PNG.';

  @override
  String get errImageTooLarge => 'Imagem demasiado grande. Máximo de 5MB.';

  @override
  String get errPropertyAdNotFound => 'Anúncio não encontrado.';

  @override
  String get errInvalidRate => 'Taxa de câmbio inválida.';

  @override
  String get signIn => 'Iniciar sessão';

  @override
  String get signUp => 'Registar';

  @override
  String get email => 'E-mail';

  @override
  String get requiredField => 'Campo obrigatório!';

  @override
  String get invalidName => 'Nome inválido!';

  @override
  String get invalidEmail => 'E-mail inválido!';

  @override
  String get invalidPassword => 'Palavra-passe inválida!';

  @override
  String get passwordMinLength =>
      'A palavra-passe deve conter pelo menos 8 caracteres.';

  @override
  String get passwordLowercase =>
      'A palavra-passe deve conter pelo menos 1 letra minúscula.';

  @override
  String get passwordUppercase =>
      'A palavra-passe deve conter pelo menos 1 letra maiúscula.';

  @override
  String get passwordNumber =>
      'A palavra-passe deve conter pelo menos 1 número.';

  @override
  String get passwordSpecialChar =>
      'A palavra-passe deve conter pelo menos 1 carácter especial (ex: ?, !, @).';

  @override
  String get passwordMismatch => 'As palavras-passe não coincidem!';

  @override
  String get password => 'Palavra-passe';

  @override
  String get name => 'Nome';

  @override
  String get confirmEmail => 'Confirme o e-mail';

  @override
  String get confirmPassword => 'Confirme a palavra-passe';

  @override
  String get alreadyHaveAccount => 'Já tem conta?';

  @override
  String get dontHaveAccount => 'Ainda não tem conta?';

  @override
  String get registerNow => 'Registe-se agora';

  @override
  String get settings => 'Definições';

  @override
  String get logout => 'Terminar sessão';

  @override
  String get registerYourAccount => 'Registe a sua conta';

  @override
  String get registrationCompleted => 'Registo concluído';

  @override
  String get about => 'Sobre';

  @override
  String get version => 'Versão';

  @override
  String get language => 'Idioma';

  @override
  String get changeAppLanguage => 'Alterar o idioma da aplicação';

  @override
  String get home => 'Início';

  @override
  String get homeSearchHint => 'Pesquisar imóveis...';

  @override
  String get homeFilterAll => 'Todos';

  @override
  String get homeFilterMyAds => 'Os Meus Anúncios';

  @override
  String get homeFilterRent => 'Arrendamento';

  @override
  String get homeFilterSale => 'Venda';

  @override
  String get homeEmptyTitle => 'Nenhum imóvel encontrado';

  @override
  String get homeEmptyDescription => 'Tente ajustar os filtros ou a pesquisa';

  @override
  String get homeLoadError => 'Erro ao carregar imóveis';

  @override
  String get homeRetry => 'Tentar novamente';

  @override
  String get deleteAdDialogTitle => 'Eliminar anúncio';

  @override
  String get deleteAdDialogMessage =>
      'Tem a certeza que deseja eliminar este anúncio?';

  @override
  String get deleteAdDialogSubMessage => 'Esta ação não pode ser revertida.';

  @override
  String get deleteAdDialogConfirm => 'Eliminar';

  @override
  String get deleteAdDialogCancel => 'Cancelar';

  @override
  String get createAdTitle => 'Criar Anúncio';

  @override
  String get createAdSectionDetails => 'Detalhes do Anúncio';

  @override
  String get createAdType => 'Tipo';

  @override
  String get createAdSale => 'Venda';

  @override
  String get createAdRent => 'Arrendamento';

  @override
  String get createAdPrice => 'Preço (BRL)';

  @override
  String get createAdPriceHint => 'ex: 450000.00';

  @override
  String get createAdInvalidPrice =>
      'Introduza um preço válido superior a zero';

  @override
  String get createAdSectionAddress => 'Morada';

  @override
  String get createAdZipCode => 'Código Postal';

  @override
  String get createAdInvalidZip =>
      'Introduza um código postal válido com 8 dígitos';

  @override
  String get createAdStreet => 'Rua';

  @override
  String get createAdNumber => 'Número';

  @override
  String get createAdNeighborhood => 'Freguesia';

  @override
  String get createAdCity => 'Cidade';

  @override
  String get createAdState => 'Distrito (UF)';

  @override
  String get createAdComplement => 'Complemento';

  @override
  String get createAdComplementHint => 'Apto, sala, etc. (opcional)';

  @override
  String get createAdSectionImage => 'Imagem do Imóvel';

  @override
  String get createAdAddImage => 'Toque para adicionar uma imagem';

  @override
  String get createAdChangeImage => 'Toque para alterar a imagem';

  @override
  String get createAdImageHint => 'JPEG ou PNG, máx. 5MB';

  @override
  String get createAdSubmit => 'Publicar Anúncio';

  @override
  String get createAdSuccess => 'Anúncio publicado com sucesso!';

  @override
  String get exchangeRateSheetTitle => 'Câmbio BRL → USD';

  @override
  String get exchangeRateDialogMessage =>
      'Introduza a taxa de câmbio BRL para USD atual';

  @override
  String get exchangeRateFieldLabel => 'Taxa (1 BRL = ? USD)';

  @override
  String get exchangeRateFieldHint => '0,18';

  @override
  String get exchangeRateSaveButton => 'Guardar câmbio';

  @override
  String get exchangeRateInvalidValue =>
      'Introduza um valor válido superior a zero';

  @override
  String get exchangeRateSaveSuccess => 'Câmbio guardado com sucesso!';

  @override
  String get exchangeRateButtonTooltip => 'Câmbio';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get errUnknown => 'Ocorreu um erro inesperado.';

  @override
  String get errMissingToken => 'Sessão expirada. Faça login novamente.';

  @override
  String get errInvalidToken => 'Sessão inválida. Faça login novamente.';

  @override
  String get errInvalidRequest => 'Requisição inválida.';

  @override
  String get errEmailAlreadyUsed => 'Este e-mail já está em uso.';

  @override
  String get errUserNotFound => 'Usuário não encontrado.';

  @override
  String get errInvalidCredentials => 'E-mail ou senha incorretos.';

  @override
  String get errInvalidCEP => 'CEP inválido.';

  @override
  String get errCEPNotFound => 'CEP não encontrado.';

  @override
  String get errExternalServiceFailure =>
      'Serviço externo indisponível. Tente novamente.';

  @override
  String get errInvalidExternalResponse =>
      'Resposta inválida do serviço externo.';

  @override
  String get errExternalBadRequest =>
      'Requisição rejeitada pelo serviço externo.';

  @override
  String get errInvalidAdType => 'Tipo de anúncio inválido.';

  @override
  String get errInvalidPrice =>
      'Preço inválido. Informe um valor maior que zero.';

  @override
  String get errMissingAddressField =>
      'Preencha todos os campos obrigatórios do endereço.';

  @override
  String get errInvalidImageType =>
      'Formato de imagem inválido. Use JPG ou PNG.';

  @override
  String get errImageTooLarge => 'Imagem muito grande. Máximo de 5MB.';

  @override
  String get errPropertyAdNotFound => 'Anúncio não encontrado.';

  @override
  String get errInvalidRate => 'Taxa de câmbio inválida.';

  @override
  String get signIn => 'Entrar';

  @override
  String get signUp => 'Cadastrar';

  @override
  String get email => 'E-mail';

  @override
  String get requiredField => 'Campo obrigatório!';

  @override
  String get invalidName => 'Nome inválido!';

  @override
  String get invalidEmail => 'Email inválido!';

  @override
  String get invalidPassword => 'Senha inválida!';

  @override
  String get passwordMinLength => 'Senha deve conter no mínimo 8 dígitos.';

  @override
  String get passwordLowercase =>
      'Senha deve conter no mínimo 1 dígito minúsculo.';

  @override
  String get passwordUppercase =>
      'Senha deve conter no mínimo 1 dígito maiúsculo.';

  @override
  String get passwordNumber => 'Senha deve conter no mínimo 1 dígito numérico.';

  @override
  String get passwordSpecialChar =>
      'Senha deve conter no mínimo 1 caractere especial (Ex: ?, !, @).';

  @override
  String get passwordMismatch => 'Senhas diferentes!';

  @override
  String get password => 'Senha';

  @override
  String get name => 'Nome';

  @override
  String get confirmEmail => 'Confirme o email';

  @override
  String get confirmPassword => 'Confirme a senha';

  @override
  String get alreadyHaveAccount => 'Já possui uma conta?';

  @override
  String get dontHaveAccount => 'Não possui uma conta?';

  @override
  String get registerNow => 'Cadastre-se agora';

  @override
  String get settings => 'Configurações';

  @override
  String get logout => 'Sair';

  @override
  String get registerYourAccount => 'Cadastre sua conta';

  @override
  String get registrationCompleted => 'Cadastro concluído';

  @override
  String get about => 'Sobre';

  @override
  String get version => 'Versão';

  @override
  String get language => 'Idioma';

  @override
  String get changeAppLanguage => 'Alterar o idioma do aplicativo';

  @override
  String get home => 'Início';

  @override
  String get homeSearchHint => 'Pesquisar imóveis...';

  @override
  String get homeFilterAll => 'Todos';

  @override
  String get homeFilterMyAds => 'Meus Anúncios';

  @override
  String get homeFilterRent => 'Aluguel';

  @override
  String get homeFilterSale => 'Venda';

  @override
  String get homeEmptyTitle => 'Nenhum imóvel encontrado';

  @override
  String get homeEmptyDescription => 'Tente ajustar os filtros ou a pesquisa';

  @override
  String get homeLoadError => 'Erro ao carregar imóveis';

  @override
  String get homeRetry => 'Tentar novamente';

  @override
  String get deleteAdDialogTitle => 'Excluir anúncio';

  @override
  String get deleteAdDialogMessage =>
      'Tem certeza que deseja excluir este anúncio?';

  @override
  String get deleteAdDialogSubMessage => 'Essa ação não pode ser desfeita.';

  @override
  String get deleteAdDialogConfirm => 'Excluir';

  @override
  String get deleteAdDialogCancel => 'Cancelar';

  @override
  String get createAdTitle => 'Criar Anúncio';

  @override
  String get createAdSectionDetails => 'Detalhes do Anúncio';

  @override
  String get createAdType => 'Tipo';

  @override
  String get createAdSale => 'Venda';

  @override
  String get createAdRent => 'Aluguel';

  @override
  String get createAdPrice => 'Preço (BRL)';

  @override
  String get createAdPriceHint => 'ex: 450000.00';

  @override
  String get createAdInvalidPrice => 'Informe um preço válido maior que zero';

  @override
  String get createAdSectionAddress => 'Endereço';

  @override
  String get createAdZipCode => 'CEP';

  @override
  String get createAdInvalidZip => 'Informe um CEP válido com 8 dígitos';

  @override
  String get createAdStreet => 'Logradouro';

  @override
  String get createAdNumber => 'Número';

  @override
  String get createAdNeighborhood => 'Bairro';

  @override
  String get createAdCity => 'Cidade';

  @override
  String get createAdState => 'Estado (UF)';

  @override
  String get createAdComplement => 'Complemento';

  @override
  String get createAdComplementHint => 'Apto, sala, etc. (opcional)';

  @override
  String get createAdSectionImage => 'Imagem do Imóvel';

  @override
  String get createAdAddImage => 'Toque para adicionar uma imagem';

  @override
  String get createAdChangeImage => 'Toque para trocar a imagem';

  @override
  String get createAdImageHint => 'JPEG ou PNG, máx. 5MB';

  @override
  String get createAdSubmit => 'Publicar Anúncio';

  @override
  String get createAdSuccess => 'Anúncio publicado com sucesso!';

  @override
  String get exchangeRateSheetTitle => 'Cotação BRL → USD';

  @override
  String get exchangeRateDialogMessage =>
      'Informe a taxa de câmbio BRL para USD atual';

  @override
  String get exchangeRateFieldLabel => 'Taxa (1 BRL = ? USD)';

  @override
  String get exchangeRateFieldHint => '0,18';

  @override
  String get exchangeRateSaveButton => 'Salvar cotação';

  @override
  String get exchangeRateInvalidValue => 'Informe um valor válido maior que 0';

  @override
  String get exchangeRateSaveSuccess => 'Cotação salva com sucesso!';

  @override
  String get exchangeRateButtonTooltip => 'Cotação';
}
