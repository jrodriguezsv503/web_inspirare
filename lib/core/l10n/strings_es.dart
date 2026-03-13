import 'package:inspirare/core/l10n/app_strings.dart';

/// Spanish strings for the INSPIRARE landing page.
class StringsEs extends AppStrings {
  // ── Navigation ──────────────────────────────────────────────────────
  @override
  String get navHome => 'Inicio';
  @override
  String get navServices => 'Servicios';
  @override
  String get navWhyUs => 'Nosotros';
  @override
  String get navPortfolio => 'Portafolio';
  @override
  String get navProcess => 'Proceso';
  @override
  String get navPricing => 'Precios';
  @override
  String get navFaq => 'FAQ';
  @override
  String get navContact => 'Contacto';
  @override
  String get navGetFreeEstimate => 'Cotizar Gratis';

  // ── Hero ────────────────────────────────────────────────────────────
  @override
  String get heroBadge =>
      'Agencia de Desarrollo de Software \u2022 Centroam\u00e9rica';
  @override
  String get heroHeadlinePart1 => 'Creamos Software\nQue ';
  @override
  String get heroHeadlineAccent => 'Impulsa';
  @override
  String get heroHeadlinePart2 => ' Ingresos';
  @override
  String get heroSubtitle =>
      'INSPIRARE es una agencia de desarrollo de software en El Salvador. '
      'Dise\u00f1amos, construimos y escalamos aplicaciones web y m\u00f3viles '
      'personalizadas para empresas en crecimiento en todo el mundo.';
  @override
  String get heroCtaPrimary => 'Obt\u00e9n Tu Cotizaci\u00f3n Gratis';
  @override
  String get heroCtaSecondary => 'Ver Nuestro Trabajo';
  @override
  String get heroBadgeDuns => 'D-U-N-S\u00ae Verificado';
  @override
  String get heroBadgeIp => '100% Propiedad de IP';
  @override
  String get heroMetric1Value => '20+';
  @override
  String get heroMetric1Label => 'A\u00f1os de Experiencia';
  @override
  String get heroMetric2Value => '4';
  @override
  String get heroMetric2Label => 'Productos SaaS Activos';
  @override
  String get heroMetric3Value => 'CST';
  @override
  String get heroMetric3Label => 'Misma Zona Horaria';
  @override
  String get heroMetric4Value => '\u{1F6E1}\uFE0F';
  @override
  String get heroMetric4Label => 'D-U-N-S\u00ae Verificado';

  // ── Services ────────────────────────────────────────────────────────
  @override
  String get servicesLabel => 'Lo Que Hacemos';
  @override
  String get servicesTitle => 'Desarrollo de Software\nde Principio a Fin';
  @override
  String get servicesSubtitle =>
      'Desde la idea hasta el lanzamiento y el soporte continuo. '
      'Nos encargamos del diseño, desarrollo y despliegue para que '
      'puedas enfocarte en hacer crecer tu negocio.';
  @override
  List<ServiceCardStrings> get serviceCards => const [
    ServiceCardStrings(
      title: 'Apps Web Que Escalan Con Tu Negocio',
      description:
          'Dashboards SaaS, portales de clientes y sistemas de administraci\u00f3n '
          'que crecen contigo \u2014 construidos para alto rendimiento desde el d\u00eda uno.',
    ),
    ServiceCardStrings(
      title: 'Un C\u00f3digo, Dos Plataformas',
      description:
          'Lanza tu app en iPhone y Android al mismo tiempo \u2014 '
          'con un solo c\u00f3digo que reduce tu costo y tiempo de desarrollo a la mitad.',
    ),
    ServiceCardStrings(
      title: 'De Idea a Mercado en Semanas',
      description:
          'Valida tu concepto r\u00e1pido. Ayudamos a startups a construir, probar '
          'y lanzar su MVP para que empieces a obtener retroalimentaci\u00f3n real.',
    ),
    ServiceCardStrings(
      title: 'Funciones con IA Real, No Solo Promesas',
      description:
          'Chatbots, procesamiento de documentos, pipelines RAG y automatizaci\u00f3n '
          '\u2014 funciones de IA en producci\u00f3n, no solo prototipos.',
    ),
    ServiceCardStrings(
      title: 'Construido en Google Cloud',
      description:
          'Infraestructura serverless, auto-escalable y optimizada en costos. '
          'Tu app se mantiene r\u00e1pida y confiable mientras creces.',
    ),
    ServiceCardStrings(
      title: 'Dise\u00f1o Que Convierte',
      description:
          'Interfaces centradas en el usuario que lucen genial y generan resultados. '
          'Desde wireframes hasta dise\u00f1os pulidos listos para producci\u00f3n.',
    ),
  ];

  // ── Why INSPIRARE ──────────────────────────────────────────────────
  @override
  String get whyLabel => 'Por Qu\u00e9 INSPIRARE';
  @override
  String get whyTitle => 'Tu Ventaja\nSubcontratando Con Nosotros';
  @override
  String get whySubtitle =>
      'Combinamos ingeniería de clase mundial con eficiencia en costos.\n'
      'Sin intermediarios ni problemas de zona horaria';
  @override
  List<WhyCardStrings> get whyCards => const [
    WhyCardStrings(
      title: 'Negocio Verificado D-U-N-S\u00ae',
      description:
          'Verificados independientemente por Dun & Bradstreet (No. 816056716). '
          'Cumplimos los mismos est\u00e1ndares de credibilidad requeridos por Apple, '
          'Google y departamentos de compras Fortune 500.',
    ),
    WhyCardStrings(
      title: 'T\u00fa Eres Due\u00f1o del 100% de Tu IP',
      description:
          'Tu c\u00f3digo fuente y propiedad intelectual te pertenecen desde el '
          'd\u00eda uno. Firmamos NDAs como pr\u00e1ctica est\u00e1ndar y trabajamos con tu '
          'equipo legal en cualquier requerimiento.',
    ),
    WhyCardStrings(
      title: '4 Productos SaaS en Producci\u00f3n',
      description:
          'No solo hacemos outsourcing \u2014 construimos, desplegamos y mantenemos '
          'nuestros propios productos SaaS con usuarios y revenue reales.',
    ),
    WhyCardStrings(
      title: '20+ A\u00f1os y Entrega de Extremo a Extremo',
      description:
          'Ingenieros senior con certificaciones Apple y Cisco. '
          'Dise\u00f1o \u2192 c\u00f3digo \u2192 despliegue \u2192 soporte \u2014 un solo equipo '
          'maneja todo, sin malabarismo de proveedores.',
    ),
    WhyCardStrings(
      title: 'Google Cloud Nativo',
      description:
          'Flutter con c\u00f3digo \u00fanico para web + m\u00f3vil, AI/ML en producci\u00f3n '
          '(no solo prototipos), y seguridad primero: 2FA, encriptaci\u00f3n '
          'y frameworks de cumplimiento.',
    ),
    WhyCardStrings(
      title: 'Misma Zona Horaria, Acceso Directo',
      description:
          'Zona horaria CST \u2014 igual que Chicago, Dallas y Houston. '
          'Habla directamente con los ingenieros que construyen tu producto '
          'v\u00eda Slack, Zoom y Linear. Sin intermediarios.',
    ),
  ];

  // ── Portfolio ──────────────────────────────────────────────────────
  @override
  String get portfolioLabel => 'Nuestro Trabajo';
  @override
  String get portfolioTitle => 'Proyectos Que\nGeneran Resultados';
  @override
  String get portfolioSubtitle =>
      'Productos reales construidos para negocios reales. '
      'Esto es lo que hemos entregado.';
  @override
  String get portfolioChallenge => 'DESAF\u00cdO';
  @override
  String get portfolioSolution => 'SOLUCI\u00d3N';
  @override
  String get portfolioResults => 'RESULTADOS';
  @override
  String get portfolioViewLive => 'Ver en Vivo';
  @override
  List<ProjectStrings> get projects => const [
    ProjectStrings(
      name: 'ContaSAS.ia',
      subtitle: 'SaaS con IA para Contabilidad y Cumplimiento Fiscal',
      challenge:
          'Las peque\u00f1as empresas necesitaban contabilidad asequible asistida '
          'por IA que entienda la legislaci\u00f3n fiscal local.',
      solution:
          'Construimos una plataforma SaaS completa con contabilidad automatizada, '
          'c\u00e1lculos de IVA y un asistente legal de IA entrenado en legislaci\u00f3n '
          'comercial salvadore\u00f1a.',
      results: [
        'SaaS en producci\u00f3n sirviendo negocios reales',
        'Asistente legal IA para consultas de cumplimiento',
        'Declaraciones automatizadas de IVA e impuesto sobre la renta',
      ],
      status: 'Activo \u2022 Suscriptores de Pago',
    ),
    ProjectStrings(
      name: 'Factura F\u00e1cil DTE',
      subtitle: 'Facturaci\u00f3n Electr\u00f3nica Certificada por el Gobierno',
      challenge:
          'Las empresas necesitaban un sistema de facturaci\u00f3n electr\u00f3nica '
          'integrado con el Ministerio de Hacienda de El Salvador.',
      solution:
          'Construimos una plataforma de facturaci\u00f3n en tiempo real que maneja '
          'm\u00faltiples tipos de documentos con validaci\u00f3n de API gubernamental.',
      results: [
        'Certificado por el Ministerio de Hacienda',
        'Procesando facturas reales para clientes de pago',
        'Generaci\u00f3n de facturas en menos de un segundo',
      ],
      status: 'Activo \u2022 Clientes de Pago',
    ),
    ProjectStrings(
      name: 'El Bicho IA',
      subtitle: 'Chatbot IA Hiperlocal con Modelo Fine-Tuned Personalizado',
      challenge:
          'Ning\u00fan asistente de IA entend\u00eda el contexto salvadore\u00f1o, '
          'el caliche ni las regulaciones locales.',
      solution:
          'Fine-tuned Gemma 3 en Vertex AI usando QLoRA, construimos un pipeline RAG '
          'con documentos legales y creamos un "normalizador de caliche" para el '
          'dialecto local.',
      results: [
        'Modelo de IA fine-tuned personalizado en producci\u00f3n',
        'Modelo de monetizaci\u00f3n B2B',
        '770+ rutas de buses nacionales en base de datos',
      ],
      status: 'Activo \u2022 Modelo B2B',
    ),
    ProjectStrings(
      name: 'TRAMA Store',
      subtitle: 'Plataforma E-Commerce Desde Cero',
      challenge:
          'Una marca de ropa masculina necesitaba una tienda en l\u00ednea completa '
          'con identidad de marca y procesamiento de pagos.',
      solution:
          'Dise\u00f1amos y construimos una experiencia de e-commerce completa '
          'incluyendo cat\u00e1logo de productos, flujo de checkout y sistema de marca.',
      results: [
        'Tienda e-commerce activa',
        'Experiencia de compra mobile-first',
        'Pasarela de pago integrada',
      ],
      status: 'Activo \u2022 trama.store',
    ),
  ];

  // ── Process ────────────────────────────────────────────────────────
  @override
  String get processLabel => 'C\u00f3mo Trabajamos';
  @override
  String get processTitle => 'De Idea a Lanzamiento\nen 5 Pasos';
  @override
  String get processSubtitle =>
      'Un proceso probado que reduce riesgos y entrega resultados. '
      'Transparente, predecible y colaborativo.';
  @override
  List<StepStrings> get processSteps => const [
    StepStrings(
      title: 'Descubrimiento',
      description:
          'Conocemos tu negocio, objetivos y requisitos. Definimos alcance y hoja de ruta.',
    ),
    StepStrings(
      title: 'Dise\u00f1o',
      description:
          'Wireframes, prototipos y dise\u00f1o UI/UX. T\u00fa apruebas antes de que codifiquemos.',
    ),
    StepStrings(
      title: 'Desarrollo',
      description:
          'Sprints \u00e1giles con demos semanales. Ves el progreso en tiempo real.',
    ),
    StepStrings(
      title: 'Despliegue',
      description:
          'Testing, QA y lanzamiento. Nosotros manejamos la infraestructura y el go-live.',
    ),
    StepStrings(
      title: 'Soporte',
      description:
          'Mantenimiento continuo, actualizaciones y escalamiento conforme tu negocio crece.',
    ),
  ];

  // ── Pricing ────────────────────────────────────────────────────────
  @override
  String get pricingLabel => 'Precios';
  @override
  String get pricingTitle => 'Modelos de\nContrataci\u00f3n Flexibles';
  @override
  String get pricingSubtitle =>
      'Elige el modelo que se adapte a tu proyecto. '
      'Todos incluyen comunicaci\u00f3n directa con ingenieros senior.';
  @override
  String get pricingMostPopular => 'M\u00c1S POPULAR';
  @override
  String get pricingIdealFor => 'Ideal para:';
  @override
  String get pricingCta => 'Hablemos de Tu Proyecto';
  @override
  List<PricingCardStrings> get pricingCards => const [
    PricingCardStrings(
      title: 'Precio Fijo',
      description:
          'Ideal para proyectos bien definidos con alcance y entregables claros.',
      idealFor: 'MVPs, landing pages, funcionalidades espec\u00edficas',
      features: [
        'Alcance y cronograma definidos',
        'Presupuesto predecible',
        'Pagos basados en hitos',
        'Solicitudes de cambio v\u00eda proceso CR',
        'Documentaci\u00f3n completa incluida',
      ],
    ),
    PricingCardStrings(
      title: 'Tiempo y Materiales',
      description:
          'Ideal para proyectos en evoluci\u00f3n donde los requisitos pueden cambiar durante el desarrollo.',
      idealFor: 'Desarrollo continuo, proyectos complejos',
      features: [
        'Paga por horas reales trabajadas',
        'Ajustes flexibles de alcance',
        'Reportes de progreso semanales',
        'Entrega basada en sprints',
        'Seguimiento transparente de tiempo',
      ],
    ),
    PricingCardStrings(
      title: 'Equipo Dedicado',
      description:
          'Ideal para proyectos a largo plazo que necesitan capacidad de ingenier\u00eda consistente y a tiempo completo.',
      idealFor: 'Staff augmentation, equipos de producto',
      features: [
        'Ingenieros dedicados a tiempo completo',
        'Totalmente integrados con tu equipo',
        'Precio mensual por retainer',
        'Acceso directo a gesti\u00f3n',
        'Escala seg\u00fan necesites',
      ],
    ),
  ];

  // ── FAQ ─────────────────────────────────────────────────────────────
  @override
  String get faqLabel => 'FAQ';
  @override
  String get faqTitle => 'Preguntas Frecuentes';
  @override
  String get faqSubtitle =>
      'Todo lo que necesitas saber sobre trabajar con INSPIRARE.';
  @override
  List<FaqStrings> get faqs => const [
    FaqStrings(
      question: '\u00bfD\u00f3nde est\u00e1 ubicado su equipo?',
      answer:
          'Estamos en El Salvador, Centroam\u00e9rica. Nuestra zona horaria es CST '
          '(Hora Est\u00e1ndar Central) \u2014 igual que Chicago, Dallas y Houston. '
          'Esto significa colaboraci\u00f3n en tiempo real durante horario laboral de EE.UU. sin retrasos.',
    ),
    FaqStrings(
      question: '\u00bfEn qu\u00e9 tecnolog\u00edas se especializan?',
      answer:
          'Nuestro stack principal es Flutter (para apps m\u00f3viles y web multiplataforma), '
          'Dart, Firebase y Google Cloud Platform. Tambi\u00e9n integramos soluciones de AI/ML '
          'usando APIs de Gemini y OpenAI. Este stack moderno nos permite entregar m\u00e1s '
          'r\u00e1pido y a menor costo que el desarrollo nativo tradicional.',
    ),
    FaqStrings(
      question: '\u00bfC\u00f3mo nos comunicamos durante un proyecto?',
      answer:
          'Usamos Slack para comunicaci\u00f3n diaria, Zoom para reuniones, y Linear '
          'o Jira para gesti\u00f3n de proyectos. Tendr\u00e1s acceso directo a los '
          'ingenieros que construyen tu producto \u2014 sin gerentes de proyecto ni intermediarios. '
          'Daily standups disponibles si tu equipo los prefiere.',
    ),
    FaqStrings(
      question: '\u00bfFirman NDAs?',
      answer:
          'S\u00ed, absolutamente. Firmamos NDAs como pr\u00e1ctica est\u00e1ndar antes de cada '
          'proyecto. Tomamos en serio la protecci\u00f3n de propiedad intelectual y '
          'podemos trabajar con tu equipo legal en cualquier requerimiento espec\u00edfico.',
    ),
    FaqStrings(
      question: '\u00bfCu\u00e1l es el timeline t\u00edpico de un proyecto?',
      answer:
          'Un MVP t\u00edpicamente toma 4\u20138 semanas. Proyectos m\u00e1s grandes y complejos se '
          'entregan en fases, con el primer release usualmente en 6\u201312 semanas. '
          'Proporcionamos timelines detallados durante la fase de descubrimiento '
          'para que no haya sorpresas.',
    ),
    FaqStrings(
      question: '\u00bfC\u00f3mo funcionan los precios?',
      answer:
          'Ofrecemos tres modelos de contrataci\u00f3n: Precio Fijo (para proyectos bien definidos), '
          'Tiempo y Materiales (para requisitos en evoluci\u00f3n), y Equipo Dedicado '
          '(para trabajo continuo). Proporcionamos estimados detallados durante el descubrimiento y '
          'nuestras tarifas son 40\u201360% menores que agencias comparables en EE.UU.',
    ),
    FaqStrings(
      question:
          '\u00bfQui\u00e9n es due\u00f1o del c\u00f3digo y la propiedad intelectual?',
      answer:
          'T\u00fa eres due\u00f1o del 100% de tu c\u00f3digo fuente y propiedad intelectual desde el d\u00eda uno. '
          'Firmamos NDAs como pr\u00e1ctica est\u00e1ndar y podemos trabajar con tu equipo legal en '
          'cualquier requerimiento espec\u00edfico de IP. Est\u00e1s trabajando con un negocio '
          'verificado D-U-N-S\u00ae y legalmente constituido.',
    ),
    FaqStrings(
      question: '\u00bfC\u00f3mo manejan la seguridad y privacidad de datos?',
      answer:
          'La seguridad est\u00e1 integrada en todo lo que hacemos: autenticaci\u00f3n 2FA, '
          'encriptaci\u00f3n de datos en reposo y en tr\u00e1nsito, y arquitectura lista para cumplimiento. '
          'Seguimos las mejores pr\u00e1cticas de seguridad OWASP y podemos cumplir con '
          'requisitos GDPR/CCPA para tu proyecto.',
    ),
  ];

  // ── CTA / Contact ──────────────────────────────────────────────────
  @override
  String get ctaReadyLabel => '\u00bfLISTO PARA EMPEZAR?';
  @override
  String get ctaHeadline => 'Construyamos\nAlgo Grandioso';
  @override
  String get ctaSubtitle =>
      'Cu\u00e9ntanos sobre tu proyecto y te responderemos en '
      '24 horas con una cotizaci\u00f3n y timeline gratuitos.';
  @override
  String get ctaTrustSignal =>
      'Negocio verificado D-U-N-S\u00ae y legalmente constituido. '
      'T\u00fa eres due\u00f1o del 100% de tu c\u00f3digo e IP.';
  @override
  String get ctaEmail => 'hello@inspirare.app';
  @override
  String get ctaWhatsapp => 'WhatsApp: +503 7933-6960';
  @override
  String get ctaTimezone => 'CST (UTC-6) \u2022 Igual que Chicago';
  @override
  String get ctaLocation => 'El Salvador, Centroam\u00e9rica';
  @override
  String get ctaFormTitle => 'Obt\u00e9n Tu Cotizaci\u00f3n Gratis';
  @override
  String get ctaFormSubtitle =>
      'Llena el formulario y te responderemos en 24 horas.';
  @override
  String get ctaFormName => 'Nombre Completo *';
  @override
  String get ctaFormNameHint => 'Juan P\u00e9rez';
  @override
  String get ctaFormEmail => 'Email de Trabajo *';
  @override
  String get ctaFormEmailHint => 'juan@empresa.com';
  @override
  String get ctaFormCompany => 'Empresa';
  @override
  String get ctaFormCompanyHint => 'Empresa S.A.';
  @override
  String get ctaFormBudget => 'Rango de Presupuesto';
  @override
  String get ctaFormBudgetHint => 'Selecciona un rango';
  @override
  List<String> get ctaFormBudgetOptions => const [
    'Menos de \$10K',
    '\$10K - \$25K',
    '\$25K - \$50K',
    '\$50K+',
    'A\u00fan no estoy seguro',
  ];
  @override
  String get ctaFormMessage => 'Descripci\u00f3n del Proyecto *';
  @override
  String get ctaFormMessageHint =>
      'Cu\u00e9ntanos sobre tu proyecto, objetivos y timeline...';
  @override
  String get ctaFormSubmit => 'Enviar Mensaje';
  @override
  String get ctaSuccessTitle => '\u00a1Gracias!';
  @override
  String get ctaSuccessMessage =>
      'Tu cliente de email deber\u00eda abrirse con el mensaje pre-llenado. '
      'Te responderemos en 24 horas.';
  @override
  String get ctaSuccessSendAnother => 'Enviar otro mensaje';

  // ── Footer ─────────────────────────────────────────────────────────
  @override
  String get footerDescription =>
      'Agencia de desarrollo de software desde El Salvador. '
      'Construimos aplicaciones web y m\u00f3viles personalizadas para empresas de todo el mundo.';
  @override
  String get footerDuns => 'D-U-N-S\u00ae 81-605-6716\nNIT: 0622-151025-101-4';
  @override
  String get footerServicesTitle => 'SERVICIOS';
  @override
  List<String> get footerServicesLinks => const [
    'Aplicaciones Web',
    'Apps M\u00f3viles',
    'Desarrollo de MVP',
    'Integraci\u00f3n de IA',
  ];
  @override
  String get footerCompanyTitle => 'EMPRESA';
  @override
  List<String> get footerCompanyLinks => const [
    'Nosotros',
    'Portafolio',
    'Precios',
    'Contacto',
  ];
  @override
  String get footerContactTitle => 'CONTACTO';
  @override
  String get footerCopyright => '\u00a9 2026 INSPIRARE S.A.S.';
  @override
  String get footerCopyrightMobile =>
      '\u00a9 2026 INSPIRARE, S.A.S. \u2014 El Salvador';
  @override
  String get footerTerms => 'T\u00e9rminos';
  @override
  String get footerPrivacy => 'Privacidad';
}
