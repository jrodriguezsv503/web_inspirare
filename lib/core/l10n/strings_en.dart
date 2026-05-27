import 'package:inspirare/core/l10n/app_strings.dart';

/// English strings for the INSPIRARE landing page.
class StringsEn extends AppStrings {
  // ── Navigation ──────────────────────────────────────────────────────
  @override
  String get navHome => 'Home';
  @override
  String get navServices => 'Services';
  @override
  String get navWhyUs => 'Why Us';
  @override
  String get navPortfolio => 'Portfolio';
  @override
  String get navProcess => 'Process';
  @override
  String get navPricing => 'Pricing';
  @override
  String get navFaq => 'FAQ';
  @override
  String get navContact => 'Contact';
  @override
  String get navGetFreeEstimate => 'Get Free Estimate';

  // ── Hero ────────────────────────────────────────────────────────────
  @override
  String get heroBadge => 'Nearshore Development Agency \u2022 Central America';
  @override
  String get heroHeadlinePart1 => 'We Build Software\nThat ';
  @override
  String get heroHeadlineAccent => 'Drives';
  @override
  String get heroHeadlinePart2 => ' Revenue';
  @override
  String get heroSubtitle =>
      'INSPIRARE is a nearshore development agency in El Salvador. '
      'We design, build, and scale custom web & mobile applications '
      'for growing US and Canadian businesses.';
  @override
  String get heroCtaPrimary => 'Get Your Free Estimate';
  @override
  String get heroCtaSecondary => 'See Our Work';
  @override
  String get heroBadgeDuns => 'D-U-N-S\u00ae Verified';
  @override
  String get heroBadgeIp => '100% IP Ownership';
  @override
  String get heroMetric1Value => '20+';
  @override
  String get heroMetric1Label => 'Years Experience';
  @override
  String get heroMetric2Value => '4';
  @override
  String get heroMetric2Label => 'SaaS Products Live';
  @override
  String get heroMetric3Value => 'CST';
  @override
  String get heroMetric3Label => 'Same Timezone';
  @override
  String get heroMetric4Value => '\u{1F6E1}\uFE0F';
  @override
  String get heroMetric4Label => 'D-U-N-S\u00ae Verified';

  // ── Services ────────────────────────────────────────────────────────
  @override
  String get servicesLabel => 'What We Do';
  @override
  String get servicesTitle => 'End-to-End Software\nDevelopment';
  @override
  String get servicesSubtitle =>
      'From idea to launch and beyond. We handle design, development, '
      'and deployment so you can focus on growing your business.';
  @override
  List<ServiceCardStrings> get serviceCards => const [
        ServiceCardStrings(
          title: 'Web Apps That Scale With Your Business',
          description:
              'SaaS dashboards, client portals, and admin systems that grow '
              'with you \u2014 built for performance from day one.',
        ),
        ServiceCardStrings(
          title: 'One Codebase, Two Platforms',
          description:
              'Launch your app on iPhone and Android at the same time \u2014 '
              'with a single codebase that cuts your development cost and '
              'timeline in half.',
        ),
        ServiceCardStrings(
          title: 'From Idea to Market in Weeks',
          description:
              'Validate your concept fast. We help startups build, test, '
              'and launch their MVP so you can start getting real feedback.',
        ),
        ServiceCardStrings(
          title: 'AI-Powered Features, Not AI Hype',
          description:
              'Chatbots, document processing, RAG pipelines, and workflow '
              'automation \u2014 AI features in production, not just prototypes.',
        ),
        ServiceCardStrings(
          title: 'Built on Google Cloud',
          description:
              'Serverless, auto-scaling, cost-optimized infrastructure. '
              'Your app stays fast and reliable as you grow.',
        ),
        ServiceCardStrings(
          title: 'Design That Converts',
          description:
              'User-centered interfaces that look great and drive results. '
              'From wireframes to polished, production-ready designs.',
        ),
      ];

  // ── Why INSPIRARE ──────────────────────────────────────────────────
  @override
  String get whyLabel => 'Why INSPIRARE';
  @override
  String get whyTitle => 'Your Nearshore\nAdvantage';
  @override
  String get whySubtitle =>
      'We combine US-level engineering quality with Central American '
      'cost efficiency. No middlemen, no timezone headaches.';
  @override
  List<WhyCardStrings> get whyCards => const [
        WhyCardStrings(
          title: 'D-U-N-S\u00ae Verified Business',
          description:
              'Independently verified by Dun & Bradstreet (No. 816056716). '
              'We meet the same credibility standards required by Apple, Google, '
              'and Fortune 500 procurement departments.',
        ),
        WhyCardStrings(
          title: 'You Own 100% of Your IP',
          description:
              'Your source code and intellectual property belong to you from '
              'day one. We sign NDAs as standard practice and work with your '
              'legal team on any requirements.',
        ),
        WhyCardStrings(
          title: '4 SaaS Products in Production',
          description:
              'We don\'t just do outsourcing \u2014 we build, deploy, and maintain '
              'our own SaaS products with real users and real revenue.',
        ),
        WhyCardStrings(
          title: '20+ Years & End-to-End Delivery',
          description:
              'Senior engineers.'
              'Design \u2192 code \u2192 deploy \u2192 support \u2014 one team '
              'handles everything, no vendor juggling.',
        ),
        WhyCardStrings(
          title: 'Google Cloud Native',
          description:
              'Flutter single-codebase for web + mobile, AI/ML in production '
              '(not just prototypes), and security-first: 2FA, encryption, '
              'and compliance frameworks.',
        ),
        WhyCardStrings(
          title: 'Same Timezone, Direct Access',
          description:
              'CST timezone \u2014 same as Chicago, Dallas, and Houston. '
              'Talk directly to the engineers building your product via Slack, '
              'Zoom, and Linear. No middlemen.',
        ),
      ];

  // ── Portfolio ──────────────────────────────────────────────────────
  @override
  String get portfolioLabel => 'Our Work';
  @override
  String get portfolioTitle => 'Projects That\nDeliver Results';
  @override
  String get portfolioSubtitle =>
      'Real products built for real businesses. '
      'Here\'s what we\'ve shipped.';
  @override
  String get portfolioChallenge => 'CHALLENGE';
  @override
  String get portfolioSolution => 'SOLUTION';
  @override
  String get portfolioResults => 'RESULTS';
  @override
  String get portfolioViewLive => 'View Live';
  @override
  List<ProjectStrings> get projects => const [
        ProjectStrings(
          name: 'ContaSAS.ia',
          subtitle: 'AI-Powered SaaS for Accounting & Tax Compliance',
          challenge:
              'Small businesses needed affordable, AI-assisted accounting '
              'that understands local tax law.',
          solution:
              'Built a full SaaS platform with automated bookkeeping, IVA '
              'calculations, and an AI legal assistant trained on Salvadoran '
              'commercial law.',
          results: [
            'Production SaaS serving real businesses',
            'AI legal assistant for compliance queries',
            'Automated IVA & income tax declarations',
          ],
          status: 'Live \u2022 Paying Subscribers',
        ),
        ProjectStrings(
          name: 'Factura F\u00e1cil DTE',
          subtitle: 'Government-Compliant Electronic Invoicing',
          challenge:
              'Businesses needed a compliant electronic invoicing system '
              'integrated with El Salvador\'s Ministry of Finance.',
          solution:
              'Built a real-time invoicing platform handling multiple document '
              'types with government API validation.',
          results: [
            'Certified by Ministry of Finance',
            'Processing real invoices for paying clients',
            'Sub-second invoice generation',
          ],
          status: 'Live \u2022 Paying Clients',
        ),
        ProjectStrings(
          name: 'El Bicho IA',
          subtitle: 'Hyperlocal AI Chatbot with Custom Fine-Tuned Model',
          challenge:
              'No AI assistant understood Salvadoran context, slang, or '
              'local regulations.',
          solution:
              'Fine-tuned Gemma 3 on Vertex AI using QLoRA, built RAG pipeline '
              'with legal documents, and created a "caliche normalizer" for '
              'local dialect.',
          results: [
            'Custom fine-tuned AI model in production',
            'B2B monetization model',
            '770+ national bus routes in database',
          ],
          status: 'Live \u2022 B2B Model',
        ),
        ProjectStrings(
          name: 'TRAMA Store',
          subtitle: 'E-Commerce Platform from Scratch',
          challenge:
              'A men\'s clothing brand needed a complete online store with '
              'brand identity and payment processing.',
          solution:
              'Designed and built a complete e-commerce experience including '
              'product catalog, checkout flow, and brand system.',
          results: [
            'Live e-commerce store',
            'Mobile-first shopping experience',
            'Integrated payment gateway',
          ],
          status: 'Live \u2022 trama.store',
        ),
        ProjectStrings(
          name: 'EXVE',
          subtitle: 'Portable Vehicle Service Dossier',
          challenge:
              'Vehicle owners lose paper service records; workshops keep '
              'siloed data; buying a used car means trusting an '
              'unverifiable history.',
          solution:
              'Mobile-first PWA where the owner logs maintenance, '
              'authorizes workshops to write to their record, and carries '
              'the full history into any inspection or resale.',
          results: [
            'Owner-controlled service ledger',
            'Workshop write-authorization flow',
            'Full vehicle history, portable',
          ],
          status: 'Live \u2022 Public Beta',
        ),
      ];

  // ── Process ────────────────────────────────────────────────────────
  @override
  String get processLabel => 'How We Work';
  @override
  String get processTitle => 'From Idea to Launch\nin 5 Steps';
  @override
  String get processSubtitle =>
      'A proven process that reduces risk and delivers results. '
      'Transparent, predictable, and collaborative.';
  @override
  List<StepStrings> get processSteps => const [
        StepStrings(
          title: 'Discovery',
          description:
              'We learn your business, goals, and requirements. Define scope and roadmap.',
        ),
        StepStrings(
          title: 'Design',
          description:
              'Wireframes, prototypes, and UI/UX design. You approve before we code.',
        ),
        StepStrings(
          title: 'Develop',
          description:
              'Agile sprints with weekly demos. You see progress in real time.',
        ),
        StepStrings(
          title: 'Deploy',
          description:
              'Testing, QA, and launch. We handle infrastructure and go-live.',
        ),
        StepStrings(
          title: 'Support',
          description:
              'Ongoing maintenance, updates, and scaling as your business grows.',
        ),
      ];

  // ── Pricing ────────────────────────────────────────────────────────
  @override
  String get pricingLabel => 'Pricing';
  @override
  String get pricingTitle => 'Flexible Engagement\nModels';
  @override
  String get pricingSubtitle =>
      'Choose the model that fits your project. '
      'All models include direct communication with senior engineers.';
  @override
  String get pricingMostPopular => 'MOST POPULAR';
  @override
  String get pricingIdealFor => 'Ideal for:';
  @override
  String get pricingCta => 'Discuss Your Project';
  @override
  List<PricingCardStrings> get pricingCards => const [
        PricingCardStrings(
          title: 'Fixed-Price',
          description:
              'Best for well-defined projects with clear scope and deliverables.',
          idealFor: 'MVPs, landing pages, specific features',
          features: [
            'Defined scope & timeline',
            'Predictable budget',
            'Milestone-based payments',
            'Change requests via CR process',
            'Full documentation included',
          ],
        ),
        PricingCardStrings(
          title: 'Time & Materials',
          description:
              'Best for evolving projects where requirements may change during development.',
          idealFor: 'Ongoing development, complex projects',
          features: [
            'Pay for actual hours worked',
            'Flexible scope adjustments',
            'Weekly progress reports',
            'Sprint-based delivery',
            'Transparent time tracking',
          ],
        ),
        PricingCardStrings(
          title: 'Dedicated Team',
          description:
              'Best for long-term projects that need consistent, full-time engineering capacity.',
          idealFor: 'Staff augmentation, product teams',
          features: [
            'Full-time dedicated engineers',
            'Fully integrated with your team',
            'Monthly retainer pricing',
            'Direct management access',
            'Scale up or down as needed',
          ],
        ),
      ];

  // ── FAQ ─────────────────────────────────────────────────────────────
  @override
  String get faqLabel => 'FAQ';
  @override
  String get faqTitle => 'Common Questions';
  @override
  String get faqSubtitle =>
      'Everything you need to know about working with INSPIRARE.';
  @override
  List<FaqStrings> get faqs => const [
        FaqStrings(
          question: 'Where is your team located?',
          answer:
              'We are based in El Salvador, Central America. Our timezone is CST '
              '(Central Standard Time) \u2014 the same as Chicago, Dallas, and Houston. '
              'This means real-time collaboration during US business hours with zero delays.',
        ),
        FaqStrings(
          question: 'What technologies do you specialize in?',
          answer:
              'Our core stack is Flutter (for cross-platform mobile & web apps), '
              'Dart, Firebase, and Google Cloud Platform. We also integrate AI/ML '
              'solutions using Gemini and OpenAI APIs. This modern stack allows us to '
              'deliver faster and at lower cost than traditional native development.',
        ),
        FaqStrings(
          question: 'How do we communicate during a project?',
          answer:
              'We use Slack for daily communication, Zoom for meetings, and Linear '
              'or Jira for project management. You\'ll have direct access to the '
              'engineers building your product \u2014 no project managers or intermediaries. '
              'Daily standups are available if your team prefers them.',
        ),
        FaqStrings(
          question: 'Do you sign NDAs?',
          answer:
              'Yes, absolutely. We sign NDAs as standard practice before every '
              'engagement. We take intellectual property protection seriously and '
              'can work with your legal team on any specific requirements.',
        ),
        FaqStrings(
          question: 'What is a typical project timeline?',
          answer:
              'An MVP typically takes 4\u20138 weeks. Larger, more complex projects are '
              'delivered in phases, with the first release usually in 6\u201312 weeks. '
              'We provide detailed timelines during the discovery phase so there are '
              'no surprises.',
        ),
        FaqStrings(
          question: 'How does pricing work?',
          answer:
              'We offer three engagement models: Fixed-Price (for well-scoped projects), '
              'Time & Materials (for evolving requirements), and Dedicated Team '
              '(for ongoing work). We provide detailed estimates during discovery and '
              'our rates are 40\u201360% lower than comparable US agencies.',
        ),
        FaqStrings(
          question: 'Who owns the code and intellectual property?',
          answer:
              'You own 100% of your source code and intellectual property from day one. '
              'We sign NDAs as standard practice and can work with your legal team on '
              'any specific IP requirements. You\'re working with a D-U-N-S\u00ae '
              'verified, legally incorporated business.',
        ),
        FaqStrings(
          question: 'How do you handle security and data privacy?',
          answer:
              'Security is built into everything we do: 2FA authentication, data '
              'encryption at rest and in transit, and compliance-ready architecture. '
              'We follow OWASP security best practices and can accommodate GDPR/CCPA '
              'requirements for your project.',
        ),
      ];

  // ── CTA / Contact ──────────────────────────────────────────────────
  @override
  String get ctaReadyLabel => 'READY TO START?';
  @override
  String get ctaHeadline => 'Let\'s Build\nSomething Great';
  @override
  String get ctaSubtitle =>
      'Tell us about your project and we\'ll get back to you within '
      '24 hours with a free estimate and timeline.';
  @override
  String get ctaTrustSignal =>
      'D-U-N-S\u00ae verified, legally incorporated business. '
      'You own 100% of your code and IP.';
  @override
  String get ctaEmail => 'hello@inspirare.app';
  @override
  String get ctaWhatsapp => 'WhatsApp: +503 7933-6960';
  @override
  String get ctaTimezone => 'CST (UTC-6) \u2022 Same as Chicago';
  @override
  String get ctaLocation => 'El Salvador, Central America';
  @override
  String get ctaFormTitle => 'Get Your Free Estimate';
  @override
  String get ctaFormSubtitle =>
      'Fill out the form and we\'ll respond within 24 hours.';
  @override
  String get ctaFormName => 'Full Name *';
  @override
  String get ctaFormNameHint => 'John Smith';
  @override
  String get ctaFormEmail => 'Work Email *';
  @override
  String get ctaFormEmailHint => 'john@company.com';
  @override
  String get ctaFormCompany => 'Company';
  @override
  String get ctaFormCompanyHint => 'Company Inc.';
  @override
  String get ctaFormBudget => 'Budget Range';
  @override
  String get ctaFormBudgetHint => 'Select a range';
  @override
  List<String> get ctaFormBudgetOptions =>
      const ['Under \$10K', '\$10K - \$25K', '\$25K - \$50K', '\$50K+', 'Not sure yet'];
  @override
  String get ctaFormMessage => 'Project Description *';
  @override
  String get ctaFormMessageHint =>
      'Tell us about your project, goals, and timeline...';
  @override
  String get ctaFormSubmit => 'Send Message';
  @override
  String get ctaSuccessTitle => 'Thank You!';
  @override
  String get ctaSuccessMessage =>
      'Your email client should open with the pre-filled message. '
      'We\'ll get back to you within 24 hours.';
  @override
  String get ctaSuccessSendAnother => 'Send another message';

  // ── Footer ─────────────────────────────────────────────────────────
  @override
  String get footerDescription =>
      'Nearshore software development agency from El Salvador. '
      'We build custom web & mobile applications for US and Canadian businesses.';
  @override
  String get footerDuns => 'D-U-N-S\u00ae 81-605-6716\nNIT: 0622-151025-101-4';
  @override
  String get footerServicesTitle => 'SERVICES';
  @override
  List<String> get footerServicesLinks =>
      const ['Web Applications', 'Mobile Apps', 'MVP Development', 'AI Integration'];
  @override
  String get footerCompanyTitle => 'COMPANY';
  @override
  List<String> get footerCompanyLinks =>
      const ['Why Us', 'Portfolio', 'Pricing', 'Contact'];
  @override
  String get footerContactTitle => 'CONTACT';
  @override
  String get footerCopyright => '\u00a9 2026 INSPIRARE S.A.S.';
  @override
  String get footerCopyrightMobile =>
      '\u00a9 2026 INSPIRARE, S.A.S. \u2014 El Salvador';
  @override
  String get footerTerms => 'Terms';
  @override
  String get footerPrivacy => 'Privacy';
}
